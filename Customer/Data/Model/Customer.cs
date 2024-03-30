using System;

namespace Customer.Data.Model
{
    public class Customer
    {
        public int CustomerId { get; set; }
        public int Ishidden { get; set; }
        public string CustomerName { get; set; }
        public char Sex { get; set; } = 'M';
        public DateTime DOB { get; set; }
        public string POB { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }

    }
}
