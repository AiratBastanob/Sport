using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace WpfSport
{
    /// <summary>
    /// Логика взаимодействия для OrderWindow.xaml
    /// </summary>
    public partial class OrderWindow : Window
    {
        private int GetIdUser;
        SportDBEntities dbmodel = new SportDBEntities();
        private OrderProduct _currentOrderProduct = new OrderProduct();
        private Product _currentProduct = new Product();
        private Order _currentOrder = new Order();
        private int Id;
        private Order CurrentOrder { get; set; }
        public OrderWindow(int IdUser,Order order)
        {
            InitializeComponent();
            CurrentOrder = order;
            GetIdUser = IdUser;                    
        }

        private void DataGridOrder_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            OrderProduct item = DataGridOrderProduct.SelectedItem as OrderProduct;
            if (item != null)
            {
                foreach (OrderProduct orderProduct in dbmodel.OrderProduct)
                {
                    if (orderProduct.OrderProductID == item.OrderProductID)
                    {
                        _currentOrderProduct = orderProduct;
                        break;
                    }
                }               
            }
            var Address = dbmodel.PickupPoint.ToArray();
            OrderAddressComboBox.Items.Clear();
            foreach (var name in Address)
            {
                OrderAddressComboBox.Items.Add(name);
            }
            CheckOutButton.IsEnabled = true;
        }

        private void CheckOutButton_Click(object sender, RoutedEventArgs e)
        {
            // Находим выбранный OrderProduct в базе данных
            OrderProduct item = DataGridOrderProduct.SelectedItem as OrderProduct;
            _currentOrderProduct = dbmodel.OrderProduct.Where(op => op.ProductID == item.ProductID).FirstOrDefault();

            StringBuilder errors = new StringBuilder();
            if (OrderAddressComboBox.SelectedIndex == -1)
            {
                errors.Append("Выберите адрес" + "\n");
            }
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }

            // Находим связанный с OrderProduct объект Order и обновляем его свойства
            _currentOrder = dbmodel.Order.Where(order => order.OrderID == _currentOrderProduct.OrderID).FirstOrDefault();
            _currentOrder.PickupPointID = OrderAddressComboBox.SelectedIndex + 1;
            _currentOrder.OrderCreateDate = DateTime.Now;
            _currentOrder.OrderDeliveryDate = DateTime.UtcNow.AddDays(6);

            // Обновляем связанный объект OrderProduct
            _currentOrderProduct.Order = _currentOrder;

            // Сохраняем изменения в базе данных
            dbmodel.SaveChanges();

            MessageBox.Show("Оформлено");
        }


        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            var productOrderForDeleting = DataGridOrderProduct.SelectedItems.Cast<OrderProduct>().ToList();

            if (MessageBox.Show($"Вы точно хотите удалить следующие {productOrderForDeleting.Count} элементов?", "Внимание!",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {                
                try
                {
                    foreach (var productOrder in productOrderForDeleting)
                    {
                        var existingProductOrder = dbmodel.OrderProduct.Find(productOrder.OrderProductID);
                        if (existingProductOrder != null)
                        {
                            dbmodel.OrderProduct.Remove(existingProductOrder);
                        }
                    }
                    dbmodel.SaveChanges();
                    MessageBox.Show("Данные удалены!", "Окно оповещений");
                    DataGridOrderProduct.ItemsSource = dbmodel.OrderProduct.ToList();
                    // Получение всех заказов заданного пользователя
                    var orders = dbmodel.Order.Where(o => o.UserID == GetIdUser);

                    // Вычисление общей стоимости заказов
                    decimal totalOrderCost = orders.Sum(o => o.OrderProduct.Sum(op => op.Product.ProductCost * op.Count));
                    SummaText.Text = totalOrderCost.ToString();

                    // Нахождение максимальной скидки среди всех товаров в заказах
                    byte maxDiscount = orders.SelectMany(o => o.OrderProduct).Max(op => op.Product.ProductMaxDiscountAmount ?? 0);
                   CountDiscount.Text = maxDiscount.ToString();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }

        private void TicketOutButton_Click(object sender, RoutedEventArgs e)
        {
            var orders = CurrentOrder;
            var app = new Microsoft.Office.Interop.Excel.Application
            {
                SheetsInNewWorkbook = 1
            };

            this.CurrentOrder = new Order();
            var workbook = app.Workbooks.Add(Type.Missing);

            Microsoft.Office.Interop.Excel.Worksheet worksheet = app.Worksheets.Item[1];
            worksheet.Name = "Card";

            worksheet.Cells[1][1] = "Order number";
            worksheet.Cells[1][2] = "Product list";
            worksheet.Cells[1][2] = "Product list";
            worksheet.Cells[1][3] = "Total cost";

            worksheet.Cells[2][1] = orders.OrderID;

            var fullProductList = string.Empty;
            fullProductList = orders.OrderProduct.Aggregate(fullProductList,
                (current, product) => current + $"{product.Product.ProductName}\n");
            worksheet.Cells[2][2] = fullProductList;
            worksheet.Cells[2][3] = orders.OrderProduct.Sum(p => p.Product.ProductCost);

            worksheet.Columns.AutoFit();

            app.Visible = true;

            app.Application.ActiveWorkbook.SaveAs(@"C:\Users\Airat\Desktop\sportmaindataGrid\WpfSport\test.xlsx");

            var excelDocument = app.Workbooks.Open(@"C:\Users\Airat\Desktop\sportmaindataGrid\WpfSport\test.xlsx");

            excelDocument.ExportAsFixedFormat(Microsoft.Office.Interop.Excel.XlFixedFormatType.xlTypePDF, @"C:\Users\Airat\Desktop\sportmaindataGrid\WpfSport\test.pdf");
            excelDocument.Close(false, "", false);
            app.Quit();
        }
    }
}
