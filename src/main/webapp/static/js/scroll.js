 function scrollToBottomAndFocus() {
        // 滚动到页面底部
        window.scrollTo(0, document.body.scrollHeight);
        
        // 将光标置于评论框
        document.getElementById('commentText').focus();
    }