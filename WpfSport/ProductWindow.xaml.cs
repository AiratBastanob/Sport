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
        private Product _currentProduct = new Product();
        StackPanel productPanel;
        int selectDiscount, selectPrice;
        public ProductWindow()
        {
            InitializeComponent();
            DataContext = _currentProduct;
            LoadComponent(false);
            LoadDiscountComboBox();
            LoadPriceComboBox();           
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
            productPanel = productsPanel;
            using (var db = new SportDBEntities())
            {
                var productsAll = db.Product.ToList();
                if (Check == false)
                {
                    products = productsAll;
                }
                else
                {
                    products = productsAll;
                    if (selectDiscount == 0)
                    {
                        products = productsAll;
                    }
                    if (selectDiscount == 1)
                    {
                        products = (from items in products where items.ProductMaxDiscountAmount > 0 && items.ProductMaxDiscountAmount < 10 select items).ToList();
                    }
                    if (selectDiscount == 2)
                    {
                        products = (from items in products where items.ProductMaxDiscountAmount >= 10 && items.ProductMaxDiscountAmount < 15 select items).ToList();
                    }
                    if (selectDiscount == 3)
                    {
                        products = (from items in products where items.ProductMaxDiscountAmount > 15 select items).ToList();
                    }
                    if (selectPrice == 0)
                    {
                        products = products.OrderBy(items => items.ProductCost).ToList();
                    }

                    if (selectPrice == 1)
                    {
                        products = products.OrderByDescending(items => items.ProductCost).ToList();
                    }
                    if (selectPrice == 2)
                    {
                        products = products.OrderBy(items => items.ProductCost).ToList();
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
                    selectDiscount = 0;
                    break;
            }
            LoadComponent(true);            
        }

        /// <summary>
        /// Переход на страницу с заказами
        /// </summary>
        private void ToSurchargesButton_Click(object sender, RoutedEventArgs e)
        {
            OrderWindow orderWindow = new OrderWindow();
            orderWindow.Show();
            Close();
        }
    }
}
