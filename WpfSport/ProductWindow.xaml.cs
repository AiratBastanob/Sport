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
    /// Логика взаимодействия для ProductWindow.xaml
    /// </summary>
    public partial class ProductWindow : Window
    {
        SportDBEntities dbmodel = new SportDBEntities();
        List<Product> products = new List<Product>();
        List<OrderProduct> orderProducts = new List<OrderProduct>();
        private Product _currentProduct = new Product();
        private string textsearch = "";
        private int selectDiscount, selectPrice, IsSearchText = 0, GetIdUser,CodeOrder,IdCreateOrder,GetIdSelectedProduct;
        private string FilePath { get; set; } 
        private Random randomCode;
        private bool CheckSelected = false,CheckCreatOrder=false;

        public ProductWindow(int idUser)
        {
            InitializeComponent();
            GetIdUser = idUser;
            DataContext = _currentProduct;
            LoadComponent(false);
            LoadDiscountComboBox();
            LoadPriceComboBox();
            DataGridProduct.ItemsSource = dbmodel.Product.ToList();

            using (var db = new SportDBEntities())
            {
                var Category = db.ProductCategory.ToArray();
                var Supplier = db.ProductSupplier.ToArray();
                var Manufacture = db.ProductManufacturer.ToArray();
                foreach (var name in Category)
                {
                    CategoryComboBox.Items.Add(name);
                }
                foreach (var name in Supplier)
                {
                    SupplierComboBox.Items.Add(name);
                }
                foreach (var name in Manufacture)
                {
                    ManufacturerComboBox.Items.Add(name);
                }
            }
        }

        /// <summary>
        /// Переход к последней странице
        /// </summary>
        private void ExitButton_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainWindow = new MainWindow();
            mainWindow.Show();
            Close();
        }

        /// <summary>
        /// Логика обработки посика
        /// </summary>
        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            textsearch = SearchTextBox.Text;
            if (string.IsNullOrEmpty(SearchTextBox.Text))
                IsSearchText = 0;
            else
                IsSearchText = 1;
            LoadComponent(true);
        }

        /// <summary>
        /// Подгрузка данных для ComboBox
        /// </summary>
        private void LoadDiscountComboBox()
        {
            DiscountComboBox.Items.Add("Всё");
            DiscountComboBox.Items.Add("Скидка 0-9.99%");
            DiscountComboBox.Items.Add("Скидка 10-14.99%");
            DiscountComboBox.Items.Add("Скидка >15");
        }
        private void LoadPriceComboBox()
        {
            PriceComboBox.Items.Add("По возрастанию");
            PriceComboBox.Items.Add("По убыванию");
            PriceComboBox.Items.Add("По умолчанию");
        }

        /// <summary>
        /// Логика подгрузки данных при выборе фильтрации
        /// </summary>
        private void LoadComponent(bool Check)
        {
            using (var db = new SportDBEntities())
            {
                var productsAll = db.Product.ToList();
                if (Check == false)
                {
                    products = productsAll;
                    DataGridProduct.ItemsSource = products;
                }
                else
                {
                    products = productsAll;
                    if (IsSearchText == 1)
                    {
                        products = (from items in db.Product where items.ProductName.Contains(textsearch) select items).ToList();
                    }
                    else
                    {

                    }
                    if (selectDiscount == 0)
                    {
                        products = productsAll;
                        DataGridProduct.ItemsSource = products;
                    }
                    if (selectDiscount == 1)
                    {
                        products = (from items in products where items.ProductMaxDiscountAmount > 0 && items.ProductMaxDiscountAmount < 10 select items).ToList();
                        DataGridProduct.ItemsSource = products;
                    }
                    if (selectDiscount == 2)
                    {
                        products = (from items in products where items.ProductMaxDiscountAmount >= 10 && items.ProductMaxDiscountAmount < 15 select items).ToList();
                        DataGridProduct.ItemsSource = products;
                    }
                    if (selectDiscount == 3)
                    {
                        products = (from items in products where items.ProductMaxDiscountAmount > 15 select items).ToList();
                        DataGridProduct.ItemsSource = products;
                    }
                    if (selectPrice == 0)
                    {
                        products = products.OrderBy(items => items.ProductCost).ToList();
                        DataGridProduct.ItemsSource = products;
                    }

                    if (selectPrice == 1)
                    {
                        products = products.OrderByDescending(items => items.ProductCost).ToList();
                        DataGridProduct.ItemsSource = products;
                    }

                }
            }
        }

        /// <summary>
        /// Обработчик для ComboBox со скидками
        /// </summary>
        private void DiscountComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            int select = DiscountComboBox.SelectedIndex;
            switch (select)
            {
                case 0:
                    selectDiscount = 0;
                    break;
                case 1:
                    selectDiscount = 1;
                    break;
                case 2:
                    selectDiscount = 2;
                    break;
                case 3:
                    selectDiscount = 3;
                    break;
                default:
                    selectDiscount = 0;
                    break;
            }
            LoadComponent(true);
        }

        /// <summary>
        /// Обработчик для ComboBox с ценами
        /// </summary>
        private void PriceComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            int select = PriceComboBox.SelectedIndex;
            switch (select)
            {
                case 0:
                    selectPrice = 0;
                    break;
                case 1:
                    selectPrice = 1;
                    break;
                case 2:
                    selectPrice = 2;
                    break;
                default:
                    selectDiscount = 2;
                    break;
            }
            LoadComponent(true);
        }

        private void DataGridProduct_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

            Product item = DataGridProduct.SelectedItem as Product;
            if (item != null)
            {
                foreach (Product product in dbmodel.Product)
                {
                    if (product.ProductID == item.ProductID)
                    {
                        _currentProduct = product;
                        break;
                    }
                }
            }
            CheckSelected = true;
            if (GetIdUser != 0)
                AddButton.IsEnabled = true;
            NameArticleTextBox.Text = _currentProduct.ProductArticleNumber;
            NameProductTextBox.Text = _currentProduct.ProductName;
            PriceProductTextBox.Text = Convert.ToString(_currentProduct.ProductCost);
            MaxDiscountTextBox.Text = Convert.ToString(_currentProduct.ProductMaxDiscountAmount);
            CountDiscountTextBox.Text = Convert.ToString(_currentProduct.ProductDiscountAmount);
            CountProductTextBox.Text = Convert.ToString(_currentProduct.ProductQuantityInStock);
            ProductDescriptionTextBox.Text = _currentProduct.ProductDescription;
            CategoryComboBox.Items.Clear();
            SupplierComboBox.Items.Clear();
            ManufacturerComboBox.Items.Clear();
            OrderAddressComboBox.Items.Clear();
            if (_currentProduct.ProductPhoto != null)
            {
                var bitmap = new BitmapImage();
                MemoryStream ms = new MemoryStream(_currentProduct.ProductPhoto);
                bitmap.BeginInit();
                bitmap.StreamSource = ms;
                bitmap.EndInit();
                ProductPhotoImage.Source = (ImageSource)bitmap;
            }
            using (var db = new SportDBEntities())
            {
                var Category = db.ProductCategory.ToArray();
                var Supplier = db.ProductSupplier.ToArray();
                var Manufacture = db.ProductManufacturer.ToArray();
                var Address = db.PickupPoint.ToArray();
                foreach (var name in Category)
                {
                    CategoryComboBox.Items.Add(name);
                }
                CategoryComboBox.SelectedIndex = _currentProduct.ProductCategoryID - 1;
                foreach (var name in Supplier)
                {
                    SupplierComboBox.Items.Add(name);
                }
                SupplierComboBox.SelectedIndex = _currentProduct.ProductSupplierID - 1;
                foreach (var name in Manufacture)
                {
                    ManufacturerComboBox.Items.Add(name);
                }
                ManufacturerComboBox.SelectedIndex = _currentProduct.ProductManufacturerID - 1;
                foreach (var name in Address)
                {
                    OrderAddressComboBox.Items.Add(name);
                }               
            }          
        }

        private void AddButton_Click(object sender, RoutedEventArgs e)
        {
            StringBuilder errors = new StringBuilder();
            if (OrderAddressComboBox.SelectedIndex == -1)
                errors.Append("Выберите адрес" + "\n");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            randomCode = new Random();
            CodeOrder = randomCode.Next(1000, 9999);
            Order order = new Order { OrderStatusID = 1, PickupPointID = OrderAddressComboBox.SelectedIndex + 1, OrderCreateDate = DateTime.Now, OrderDeliveryDate = DateTime.UtcNow.AddDays(6), UserID = GetIdUser, OrderGetCode = CodeOrder };
            dbmodel.Order.Add(order);            
            dbmodel.SaveChanges();
            IdCreateOrder = order.OrderID;

            OrderProduct orderProduct = new OrderProduct { ProductID = _currentProduct.ProductID, OrderID = IdCreateOrder,  Count = 1 };
            dbmodel.OrderProduct.Add(orderProduct);
            dbmodel.SaveChanges();

            ToSurchargesButton.IsEnabled = true;            
            CheckCreatOrder = true;         
        }

        /// <summary>
        /// Переход на страницу с заказами
        /// </summary>
        private void ToSurchargesButton_Click(object sender, RoutedEventArgs e)
        {
            var AllIdOrder = (from order in dbmodel.Order where order.UserID == GetIdUser select order.OrderID).ToList();           
            var Getorder = dbmodel.Order.ToList().Find(x => x.OrderID == AllIdOrder.LastOrDefault());
            OrderWindow orderWindow = new OrderWindow(GetIdUser, Getorder);
            orderWindow.Show();
            orderWindow.DataGridOrderProduct.ItemsSource = dbmodel.OrderProduct.Where(x => AllIdOrder.Contains(x.OrderID)).ToList();
            // Получение всех заказов заданного пользователя
            var orders = dbmodel.Order.Where(o => o.UserID == GetIdUser);

            // Вычисление общей стоимости заказов
            decimal totalOrderCost = orders.Sum(o => o.OrderProduct.Sum(op => op.Product.ProductCost * op.Count));
            orderWindow.SummaText.Text = totalOrderCost.ToString();

            // Нахождение максимальной скидки среди всех товаров в заказах
            byte maxDiscount = orders.SelectMany(o => o.OrderProduct).Max(op => op.Product.ProductMaxDiscountAmount ?? 0);
            orderWindow.CountDiscount.Text = maxDiscount.ToString();
        }
    }
}
