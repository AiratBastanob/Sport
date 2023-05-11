﻿using System;
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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfSport
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        int captha;
        bool check = false;

        /// <summary>
        /// Логика авторизации
        /// </summary>

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(LoginTextBox.Text) || string.IsNullOrEmpty(PasswordTextBox.Text))
            {
                MessageBox.Show("Введите данные");
                return;
            }
            using (SportDBEntities sport = new SportDBEntities())
            {
                foreach (User user in sport.User)
                {
                    if (user.UserLogin == LoginTextBox.Text + " ")
                    {
                        if (user.UserPassword == PasswordTextBox.Text)
                        {
                            check = false;
                            if (user.Role.RoleName == "Клиент")
                            {
                                check = false;
                                MessageBox.Show("Авторазация успешна", "Клиент");
                                ProductWindow window = new ProductWindow(user.UserID);
                                window.Show();
                                this.Close();
                                return;
                            }
                            else if (user.Role.RoleName == "Администратор")
                            {
                                check = false;
                                MessageBox.Show("Авторазация успешна", "Администратор");
                                ProductFotStaff window = new ProductFotStaff();
                                window.Show();
                                this.Close();
                                return;
                            }
                            else if (user.Role.RoleName == "Менеджер")
                            {
                                check = false;
                                MessageBox.Show("Авторазация успешна", "Менеджер");
                                ProductForManager window = new ProductForManager();
                                window.Show();
                                this.Close();
                                return;
                            }
                        }
                        else
                        {
                            check = true;
                            MessageBox.Show("Неверный пароль");
                            LoginButton.Visibility = Visibility.Hidden;
                            GuestButton.Visibility = Visibility.Hidden;
                            GenerateCaptha();
                            return;
                        }
                    }
                    else
                    {
                        check = true;                      
                    }
                    
                }
                if (check == true)
                {                   
                    LoginButton.Visibility = Visibility.Hidden;
                    GuestButton.Visibility = Visibility.Hidden;
                    GenerateCaptha();
                    check = false;
                    MessageBox.Show("Такой пользователь не существует");
                    return;
                }               
            }
        }

        /// <summary>
        /// Переход на страницу для Гостя
        /// </summary>

        private void GuestButton_Click(object sender, RoutedEventArgs e)
        {
            ProductWindow window = new ProductWindow(0);
            window.Show();
            this.Close();
        } 

        /// <summary>
        /// Логика создания капчи
        /// </summary>

        private void GenerateCaptha()
        {
            int min = 1000;
            int max = 9999;
            Random random = new Random();
            captha = random.Next(min, max);
            CapthaLabel.Content = "Капча: " + captha;         
        }

        /// <summary>
        /// Логика проверки капчи
        /// </summary>

        private void CapthaButton_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(CapthTextBox.Text))
            {
                MessageBox.Show("Введите данные");
                return;
            }
            else
            {
                if (int.Parse(CapthTextBox.Text) == captha)
                {
                    LoginButton.Visibility = Visibility.Visible;
                    GuestButton.Visibility = Visibility.Visible;
                    check = false;
                }
                else
                {
                    MessageBox.Show("Проверь данные с капчой");
                    return;
                }
            }
        }
    }
}
