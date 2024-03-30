
using CustomerMS.Properties;
using System;
using System.Drawing;
using System.Windows.Forms;

namespace CustomerMS
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
        }
        Color primaryColor = Color.FromArgb(32, 85, 131);
        Color secondColor = Color.FromArgb(12, 32, 50);
        private void btnClose_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void btnCollateral_Click(object sender, EventArgs e)
        {

        }

        private void lblLogout_Click(object sender, EventArgs e)
        {

        }

        private void btnDashboard_Click(object sender, EventArgs e)
        {
            if (pList.Visible == true) pList.Visible = !pList.Visible;
            if (pLoan.Visible == true) pLoan.Visible = !pLoan.Visible;
            btnDashboard.BackColor = primaryColor;
            btnListCenter.BackColor = secondColor;
            btnTransaction.BackColor = secondColor;
            btnManagement.ForeColor = Color.White;
        }

        private void btnTransaction_Click(object sender, EventArgs e)
        {
            pLoan.Visible = !pLoan.Visible;
            if (pList.Visible == true) pList.Visible = !pList.Visible;
            btnTransaction.BackColor = primaryColor;
            btnListCenter.BackColor = secondColor;
            btnDashboard.BackColor = secondColor;
            btnManagement.ForeColor = Color.White;

            btnLoan.BackColor = secondColor;
        }

        private void btnLoan_Click(object sender, EventArgs e)
        {

        }

        private void btnListCenter_Click(object sender, EventArgs e)
        {
            pList.Visible = !pList.Visible;
            if (pLoan.Visible == true) pLoan.Visible = !pLoan.Visible;
            btnListCenter.BackColor = primaryColor;
            btnTransaction.BackColor = secondColor;
            btnDashboard.BackColor = secondColor;
            btnManagement.ForeColor = Color.White;

            //sublist control
            btnCustomer.BackColor = secondColor;
            btnCollateral.BackColor = secondColor;
            btnCollateralType.BackColor = secondColor;
            btnCreditOfficer.BackColor = secondColor;
        }
        CustomerForm.CustomerForm customer;
        private void btnCustomer_Click(object sender, EventArgs e)
        {
            btnCustomer.BackColor = primaryColor;
            btnCollateral.BackColor = secondColor;
            btnCollateralType.BackColor = secondColor;
            btnCreditOfficer.BackColor = secondColor;
            btnManagement.ForeColor = Color.White;
            btnMenu_Click(sender, e);

            if (customer == null)
            {   
                customer = new CustomerForm.CustomerForm();
                customer.TopLevel = false;
                customer.MdiParent = this;
                this.pContent.Controls.Add(customer);
            }
            customer.BringToFront();
            customer.Show();
        }

        private void btnMenu_Click(object sender, EventArgs e)
        {
            pSidebar.Visible = !pSidebar.Visible;
            if (pSidebar.Visible)
            {
                pSidebar.BringToFront();
                //pNav.BringToFront();
                btnMenu.Image = Resources.iconnavigationclose_24px;
            }
            else
            {
                btnMenu.Image = Resources.iconnavigationmenu_24px;
            }
        }

        private void btnCollateralType_Click(object sender, EventArgs e)
        {

        }

        private void btnCreditOfficer_Click(object sender, EventArgs e)
        {

        }

        private void btnManagement_Click(object sender, EventArgs e)
        {

        }
    }
}
