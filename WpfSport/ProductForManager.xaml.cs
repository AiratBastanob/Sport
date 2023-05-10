using Microsoft.Win32;
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
    /// Логика взаимодействия для ProductForManager.xaml
    /// </summary>
    public partial class ProductForManager : Window
    {
        SportDBEntities dbmodel = new SportDBEntities();
        List<Product> products = new List<Product>();
        private Product _currentProduct = new Product();
        private string textsearch = "";
        private int selectDiscount, selectPrice, IsSearchText = 0;
        private string FilePath { get; set; }
        private byte[] imageData;
        public ProductForManager()
        {
            InitializeComponent();
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

        /// <summary>
        /// Логика выбора картинки
        /// </summary>
        private void Img_Click_1(object sender, RoutedEventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog()
            {
                DefaultExt = "*.png;*.png",
                Filter = "файл png или jpg (2.png)|*jpg;*.png",
                Title = "Выберите фото"
            };
            if (!(ofd.ShowDialog() == true))
                return;
            FilePath = ofd.FileName;
            using (FileStream fs = new System.IO.FileStream(FilePath, FileMode.Open))
            {
                imageData = new byte[fs.Length];
                fs.Read(imageData, 0, imageData.Length);

                var bitmap = new BitmapImage();
                MemoryStream ms = new MemoryStream(imageData);
                bitmap.BeginInit();
                bitmap.StreamSource = ms;
                bitmap.EndInit();
                ProductPhotoImage.Source = (ImageSource)bitmap;
                _currentProduct.ProductPhoto = imageData;
            }
        }

        /// <summary>
        /// Логика обновление товара
        /// </summary>
        private void UpdateButton_Click(object sender, RoutedEventArgs e)
        {
            bool allright = false;
            Product item = DataGridProduct.SelectedItem as Product;
            foreach (Product product in dbmodel.Product)
            {
                if (product.ProductID == item.ProductID)
                {
                    _currentProduct = product;
                    break;
                }
            }
            StringBuilder errors = new StringBuilder();
            _currentProduct.ProductArticleNumber = NameArticleTextBox.Text;
            _currentProduct.ProductName = NameProductTextBox.Text;
            _currentProduct.ProductDescription = ProductDescriptionTextBox.Text;
            _currentProduct.ProductCost = Convert.ToDecimal(PriceProductTextBox.Text);
            _currentProduct.ProductMaxDiscountAmount = Convert.ToByte(MaxDiscountTextBox.Text);
            _currentProduct.ProductDiscountAmount = Convert.ToByte(CountDiscountTextBox.Text);
            _currentProduct.ProductQuantityInStock = Convert.ToInt32(CountProductTextBox.Text);
            _currentProduct.ProductSupplierID = SupplierComboBox.SelectedIndex + 1;
            _currentProduct.ProductManufacturerID = ManufacturerComboBox.SelectedIndex + 1;
            _currentProduct.ProductCategoryID = CategoryComboBox.SelectedIndex + 1;
            if (ProductPhotoImage.Source != null)
            {
                BitmapImage bitmapImage = ProductPhotoImage.Source as BitmapImage;
                MemoryStream memStream = new MemoryStream();
                JpegBitmapEncoder encoder = new JpegBitmapEncoder();
                encoder.Frames.Add(BitmapFrame.Create(bitmapImage));
                encoder.Save(memStream);
                _currentProduct.ProductPhoto = memStream.ToArray();
            }
            _currentProduct.UnitTypeID = 1;


            if (_currentProduct.ProductArticleNumber == null)
                errors.AppendLine("Введите номер артикла" + "\n");
            if (_currentProduct.ProductName == null)
                errors.Append("Введите название продукта" + "\n");
            if (_currentProduct.ProductCost == 0 || _currentProduct.ProductCost.Equals(null))
                errors.Append("Введите цену продукта" + "\n");
            if (_currentProduct.ProductMaxDiscountAmount == null)
                errors.AppendLine("Введите максимальное значение скидки" + "\n");
            if (_currentProduct.ProductDiscountAmount == null)
                errors.Append("Введите количество скидок" + "\n");
            if (_currentProduct.ProductQuantityInStock == 0)
                errors.Append("Введите количество товаров в наличии" + "\n");
            if (CategoryComboBox.SelectedIndex == -1)
                errors.Append("Выберите категорию" + "\n");
            if (ManufacturerComboBox.SelectedIndex == -1)
                errors.Append("Выберите производителя" + "\n");
            if (SupplierComboBox.SelectedIndex == -1)
                errors.Append("Выберите поставщика" + "\n");
            if (ProductDescriptionTextBox.Text == null)
                errors.Append("Введите описание" + "\n");
            if (errors.Length > 0)
            {
                MessageBox.Show(errors.ToString());
                return;
            }
            if (_currentProduct.ProductArticleNumber != null && _currentProduct.ProductName != null && _currentProduct.ProductCost != null && _currentProduct.ProductMaxDiscountAmount != null
                && _currentProduct.ProductDiscountAmount != null && _currentProduct.ProductDescription != null
                && _currentProduct.ProductQuantityInStock != 0)
                allright = true;
            if (allright == true)
            {
                try
                {
                    dbmodel.SaveChanges();
                    MessageBox.Show("Информация успешно изменена!", "Окно оповещений");
                    DataGridProduct.Items.Refresh();
                }

                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
        }

        /// <summary>
        /// Логика удаление товара
        /// </summary>
        private void DeleteButton_Click(object sender, RoutedEventArgs e)
        {
            var productForDeleting = DataGridProduct.SelectedItems.Cast<Product>().ToList();

            if (MessageBox.Show($"Вы точно хотите удалить следующие {productForDeleting.Count} элементов?", "Внимание!",
                MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                try
                {
                    dbmodel.Product.RemoveRange(productForDeleting);
                    dbmodel.SaveChanges();
                    MessageBox.Show("Данные удалены!", "Окно оповещений");
                    DataGridProduct.ItemsSource = dbmodel.Product.ToList();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message.ToString());
                }
            }
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
            ProductDescriptionTextBox.Text = _currentProduct.ProductDescription;
            CategoryComboBox.Items.Clear();
            SupplierComboBox.Items.Clear();
            ManufacturerComboBox.Items.Clear();
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
            }
        }
    }
}
