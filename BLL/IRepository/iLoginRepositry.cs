using BLL.ViewModels;
using DAL.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.IRepository
{
    public interface iLoginRepositry
    {
        public User check(LoginVM login);
        

    }
}
