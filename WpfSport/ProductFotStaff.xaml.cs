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
            DataGridDrivers.ItemsSource = dbmodel.Product.ToList();
        }
        /// <summary>
        /// Логика обработки посика
        /// </summary>
        private void SearchTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            var currentDriversName = dbmodel.Product.ToList();
            currentDriversName = currentDriversName.Where(p => p.ProductName.ToLower().Contains(SearchTextBox.Text.ToLower())).ToList();
            DataGridDrivers.ItemsSource = currentDriversName.OrderBy(p => p.ProductName).ToList();
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
    }
}
