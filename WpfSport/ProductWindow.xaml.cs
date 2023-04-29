using System;
using System.Collections.Generic;
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
        private Product _currentProduct = new Product();
        public ProductWindow()
        {
            InitializeComponent();
            DataContext = _currentProduct;
            DataGridProduct.ItemsSource = dbmodel.Product.ToList();
            LoadComboBox();
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

        /// <summary>
        /// Переход на страницу с заказами
        /// </summary>

        private void ToSurchargesButton_Click(object sender, RoutedEventArgs e)
        {
            OrderWindow orderWindow = new OrderWindow();
            orderWindow.Show();
            Close();
        }

        /// <summary>
        /// Логика нажатия кнопки
        /// </summary>

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
    }
}
