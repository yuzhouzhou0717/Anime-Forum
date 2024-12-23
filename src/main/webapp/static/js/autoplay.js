document.addEventListener("DOMContentLoaded", function () {
  // 获取轮播图容器和轮播项
  var box = document.getElementById("box_autoplay");
  var list = document.querySelector(".list ul");

  // 获取所有轮播项
  var items = document.querySelectorAll(".list li");

  // 计算轮播项的宽度
  var itemWidth = items[0].offsetWidth;

  // 在轮播项末尾添加与第一张图相同的副本
  list.innerHTML += list.innerHTML;

  // 设置初始位置
  var currentPosition = 0;

  // 添加轮播效果
  function slide() {
    currentPosition += itemWidth;

    // 如果当前位置超过所有轮播项的总宽度，则将位置重置为0
    if (currentPosition >= items.length * itemWidth) {
      // 立即将位置重置为0，实现无缝循环
      list.style.transition = "none";
      list.style.transform = "translateX(0)";
      currentPosition = 0;

      // 延迟一段时间后再恢复过渡效果
      setTimeout(function () {
        list.style.transition = "transform 0.5s ease-in-out";
      }, 0);
    } else {
      // 否则，正常移动轮播图容器
      list.style.transition = "transform 0.5s ease-in-out";
      list.style.transform = "translateX(-" + currentPosition + "px)";
    }
  }

  // 设置轮播定时器
  setInterval(slide, 5000); // 3000毫秒（3秒）切换一次轮播图
});

