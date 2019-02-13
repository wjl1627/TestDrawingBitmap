using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace DrawingBitmapMVC.Controllers
{
    public class TestController : Controller
    {
        public async Task Index()
        {
            DrawingBitmapHelp drawing = new DrawingBitmapHelp();
            var code = drawing.CreateVerifyCode(0);
            var bitmap = drawing.CreateImageCode(code);
            await drawing.CreateImageOnPageAsync(code, this.HttpContext);        // 输出图片
        }
    }
}