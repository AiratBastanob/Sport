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
    /// Логика взаимодействия для ProductFotStaff.xaml
    /// </summary>
    public partial class ProductFotStaff : Window
    {
        SportDBEntities dbmodel = new SportDBEntities();
        private Product _currentProduct = new Product();
        public ProductFotStaff()
        {
            InitializeComponent();
            DataContext = _currentProduct;
            DataGridProduct.ItemsSource = dbmodel.Product.ToList();
        }
        /// <summary>
        /// Логика обработки посика
        /// </summary>
        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var currentDriversName = dbmodel.Product.ToList();
            currentDriversName = currentDriversName.Where(p => p.ProductName.ToLower().Contains(SearchTextBox.Text.ToLower())).ToList();
            DataGridProduct.ItemsSource = currentDriversName.OrderBy(p => p.ProductName).ToList();
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

        private void DiscountComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            LoadComponent(true);
        }

        /// <summary>
        /// Подгрузка данных для ComboBox
        /// </summary>
        private void LoadComboBox()
        {
            DiscountComboBox.Items.Add("Скидка 0-9.99%");
            DiscountComboBox.Items.Add("Скидка 10-14.99%");
            DiscountComboBox.Items.Add("Скидка >15");
        }

        /// <summary>
        /// Логика подгрузки данных при выборе фильтрации
        /// </summary>

        private void LoadComponent(bool Check)
        {
            using (var db = new SportDBEntities())
            {
                if (Check == false)
                    DataGridProduct.ItemsSource = db.Product.ToList();
                else
                {
                    if (DiscountComboBox.SelectedItem.ToString() == "Скидка 0-9.99%")
                    {
                        DataGridProduct.ItemsSource = db.Product.Where(d => d.ProductDiscountAmount > 0 && d.ProductDiscountAmount < 10).ToList();
                    }
                    else if (DiscountComboBox.SelectedItem.ToString() == "Скидка 10-14.99%")
                    {
                        DataGridProduct.ItemsSource = db.Product.Where(d => d.ProductDiscountAmount >= 10 && d.ProductDiscountAmount < 15).ToList();
                    }
                    else
                    {
                        DataGridProduct.ItemsSource = db.Product.Where(d => d.ProductDiscountAmount >= 15).ToList();
                    }
                }
            }
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

        private void Img_Click_1(object sender, RoutedEventArgs e)
        { }

            private void UpdateButton_Click(object sender, RoutedEventArgs e)
        {
        }

            private void DeleteButton_Click(object sender, RoutedEventArgs e)
        { 
        }

            private void AddButton_Click(object sender, RoutedEventArgs e)
        { 
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

            UpdateButton.IsEnabled = true;
            NameArticleTextBox.Text = _currentProduct.ProductArticleNumber;
            NameProductTextBox.Text = _currentProduct.ProductName;
            PriceProductTextBox.Text = Convert.ToString(_currentProduct.ProductCost);
            MaxDiscountTextBox.Text = Convert.ToString(_currentProduct.ProductMaxDiscountAmount);
            CountDiscountTextBox.Text = Convert.ToString(_currentProduct.ProductDiscountAmount);
            CountProductTextBox.Text = Convert.ToString(_currentProduct.ProductQuantityInStock);
            if (_currentProduct.ProductPhoto != null)
            {
                var bitmap = new BitmapImage();
                MemoryStream ms = new MemoryStream(_currentProduct.ProductPhoto);
                bitmap.BeginInit();
                bitmap.StreamSource = ms;
                bitmap.EndInit();
                PersonPhotoImage.Source = (ImageSource)bitmap;
            }
        }
    }
}
