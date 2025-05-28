// MATRIX EFFECT (mantido)
const matrixCanvas = document.getElementById('matrix');
const matrixCtx = matrixCanvas.getContext('2d');
// FUMAÇA E TEXTO
const effectCanvas = document.getElementById('effect');
const effectCtx = effectCanvas.getContext('2d');

let W = window.innerWidth;
let H = window.innerHeight;
function resizeAll() {
    W = window.innerWidth;
    H = window.innerHeight;
    matrixCanvas.width = W;
    matrixCanvas.height = H;
    effectCanvas.width = W;
    effectCanvas.height = H;
}
resizeAll();
window.addEventListener('resize', resizeAll);

// MATRIX VARS
const text = 'TE AMO';
const fontSize = 18;
const verticalSpacing = fontSize * 1.3;
const spacing = fontSize * 1.2;
const columns = Math.floor(W / spacing);
const drops = [];
const trails = [];
const maxTrail = 30;
for (let i = 0; i < columns; i++) {
    drops[i] = Math.random() * -20;
    trails[i] = [];
}
function drawMatrix() {
    matrixCtx.fillStyle = 'rgba(0, 0, 0, 0.08)';
    matrixCtx.fillRect(0, 0, W, H);
    matrixCtx.font = `bold ${fontSize}px monospace`;
    matrixCtx.textAlign = 'center';
    for (let i = 0; i < columns; i++) {
        trails[i].unshift(drops[i]);
        if (trails[i].length > maxTrail) trails[i].pop();
        for (let t = 0; t < trails[i].length; t++) {
            let opacity = 1 - t / maxTrail;
            if (t === 0) {
                matrixCtx.fillStyle = `rgba(255,79,163,1)`;
                matrixCtx.shadowColor = '#ff4fa3';
                matrixCtx.shadowBlur = 10;
            } else {
                matrixCtx.fillStyle = `rgba(255,79,163,${opacity * 0.7})`;
                matrixCtx.shadowBlur = 0;
            }
            matrixCtx.fillText(text, i * spacing + spacing / 2, trails[i][t] * verticalSpacing);
        }
        matrixCtx.shadowBlur = 0;
        if (drops[i] * verticalSpacing > H && Math.random() > 0.97) {
            drops[i] = 0;
            trails[i] = [];
        }
        drops[i] += 0.7;
    }
}
setInterval(drawMatrix, 40);

// FUMAÇA E TEXTO
function SmokeParticle(x, y, color) {
    this.x = x + (Math.random() - 0.5) * 120;
    this.y = y + (Math.random() - 0.5) * 40;
    this.radius = 80 + Math.random() * 80;
    this.alpha = 0.5 + Math.random() * 0.3;
    this.vx = 0;
    this.vy = 0;
    this.life = 0;
    this.maxLife = 60 + Math.random() * 30;
    this.color = color;
}
SmokeParticle.prototype.update = function() {
    this.x += this.vx;
    this.y += this.vy;
    this.life++;
    this.alpha *= 0.98;
};
SmokeParticle.prototype.draw = function(ctx) {
    ctx.save();
    ctx.globalAlpha = Math.max(this.alpha, 0);
    let grad = ctx.createRadialGradient(this.x, this.y, 0, this.x, this.y, this.radius);
    grad.addColorStop(0, this.color);
    grad.addColorStop(1, this.color.replace(',0.5)',',0)'));
    ctx.fillStyle = grad;
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
    ctx.fill();
    ctx.restore();
};
let smokes = [];
let texts = [];
function randomVibrantColor() {
    const colors = [
        [255,0,80],    // rosa/vermelho
        [255,105,180], // pink
        [255,87,34],   // laranja
        [0,191,255],   // azul claro
        [0,255,127],   // verde água
        [255,255,0],   // amarelo
        [255,0,255],   // magenta
        [0,255,255],   // ciano
        [255,69,0],    // vermelho alaranjado
    ];
    const c = colors[Math.floor(Math.random()*colors.length)];
    return `rgba(${c[0]},${c[1]},${c[2]},0.5)`;
}
function showMeuAmor(x, y) {
    const smokeColor = randomVibrantColor();
    for (let i = 0; i < 60; i++) {
        smokes.push(new SmokeParticle(x, y, smokeColor));
    }
    texts.push({x, y, alpha: 1, life: 0});
}
function drawEffect() {
    effectCtx.clearRect(0, 0, W, H);
    // Fumaça
    for (let i = smokes.length - 1; i >= 0; i--) {
        smokes[i].update();
        smokes[i].draw(effectCtx);
        if (smokes[i].life > smokes[i].maxLife) {
            smokes.splice(i, 1);
        }
    }
    // Texto
    for (let i = texts.length - 1; i >= 0; i--) {
        let t = texts[i];
        t.life++;
        if (t.life > 100) t.alpha -= 0.02;
        effectCtx.save();
        effectCtx.globalAlpha = Math.max(t.alpha, 0);
        effectCtx.font = `bold 60px monospace`;
        effectCtx.textAlign = 'center';
        effectCtx.shadowColor = '#ff4fa3';
        effectCtx.shadowBlur = 20;
        effectCtx.fillStyle = '#ff4fa3';
        effectCtx.fillText('MEU AMOR', t.x, t.y);
        effectCtx.restore();
        if (t.alpha <= 0) texts.splice(i, 1);
    }
    requestAnimationFrame(drawEffect);
}
drawEffect();
effectCanvas.addEventListener('click', function(e) {
    const rect = effectCanvas.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;
    showMeuAmor(x, y);
});
