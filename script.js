// ハンバーガーメニューの開閉
document.addEventListener('DOMContentLoaded', function() {
    const openBtn = document.querySelector('.openbtn');
    const gNav = document.getElementById('g-nav');
    
    if (openBtn && gNav) {
        openBtn.addEventListener('click', function() {
            openBtn.classList.toggle('active');
            gNav.classList.toggle('active');
        });

        // メニュー外をクリックしたら閉じる
        document.addEventListener('click', function(e) {
            if (!gNav.contains(e.target) && !openBtn.contains(e.target)) {
                openBtn.classList.remove('active');
                gNav.classList.remove('active');
            }
        });

        // メニュー内のリンクをクリックしたら閉じる
        const navLinks = gNav.querySelectorAll('a');
        navLinks.forEach(link => {
            link.addEventListener('click', function() {
                openBtn.classList.remove('active');
                gNav.classList.remove('active');
            });
        });
    }
});

window.MathJax = {
  tex: {
    inlineMath: [['$', '$'], ['\\(', '\\)']]
  }
};