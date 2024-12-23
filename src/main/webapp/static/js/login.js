document.addEventListener('DOMContentLoaded', function() {
            // 获取提示消息元素
            var errorMsg = document.getElementById('error-msg');

            // 如果提示消息存在
            if (errorMsg) {
                // 设置定时器，在3秒后隐藏提示消息
                setTimeout(function() {
                    errorMsg.style.display = 'none';
                }, 3000); // 3000毫秒即3秒
            }
        });

