using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.ViewModels
{
    public class LoginVM
    {
        [Required]
        public string usename { get; set; }
        [DataType(DataType.Password)]
        public string password { get; set; }   

    }
}
