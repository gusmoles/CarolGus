// JavaScript extraído de coração.html
const heart = document.getElementById('heart');
const teAmo = document.getElementById('teAmo');
const stars = document.getElementById('stars');
const colors = ['#ff0000', '#ff9900', '#ffff00', '#33ff00', '#0099ff', '#6633ff', '#ff00ff'];
let heartRect;
let heartCenterX;
let heartCenterY;
let autoLaunchInterval;
let lastMouseMoveTime = 0;

// Criar estrelas no fundo
function createStars() {
    for (let i = 0; i < 100; i++) {
        const star = document.createElement('div');
        star.classList.add('star');
        
        const size = Math.random() * 2;
        star.style.width = size + 'px';
        star.style.height = size + 'px';
        
        star.style.left = Math.random() * 100 + '%';
        star.style.top = Math.random() * 100 + '%';
        
        star.style.animationDelay = Math.random() * 3 + 's';
        
        stars.appendChild(star);
    }
}

createStars();

// Atualizar posição do coração
function updateHeartPosition() {
    heartRect = heart.getBoundingClientRect();
    heartCenterX = heartRect.left + heartRect.width / 2;
    heartCenterY = heartRect.top + heartRect.height / 2;
}

updateHeartPosition();
window.addEventListener('resize', updateHeartPosition);

// Evento de clique no coração
heart.addEventListener('click', function(e) {
    // Criar fogos de artifício
    createExplosion(heartCenterX, heartCenterY, 30);
    
    // Exibir e animar o "TE AMO"
    showTeAmo();
    
    // Efeito de pulsar no coração
    heart.style.transform = 'scale(1.3)';
    setTimeout(() => {
        heart.style.transform = 'scale(1)';
    }, 300);
});

// Lançar foguetes automaticamente quando o mouse se move
document.addEventListener('mousemove', function(e) {
    const currentTime = Date.now();
    
    // Limitar a frequência de lançamento baseado no movimento do mouse
    if (currentTime - lastMouseMoveTime > 500) {
        launchRocketFromEdge();
        lastMouseMoveTime = currentTime;
    }
});

// Iniciar lançamento automático de foguetes
function startAutoLaunch() {
    if (autoLaunchInterval) clearInterval(autoLaunchInterval);
    
    autoLaunchInterval = setInterval(() => {
        launchRocketFromEdge();
    }, 2000);
}

startAutoLaunch();

// Lançar foguete de uma borda aleatória da tela
function launchRocketFromEdge() {
    updateHeartPosition();
    
    // Escolher uma borda aleatória (0: topo, 1: direita, 2: baixo, 3: esquerda)
    const edge = Math.floor(Math.random() * 4);
    let startX, startY;
    
    switch(edge) {
        case 0: // Topo
            startX = Math.random() * window.innerWidth;
            startY = -20;
            break;
        case 1: // Direita
            startX = window.innerWidth + 20;
            startY = Math.random() * window.innerHeight;
            break;
        case 2: // Baixo
            startX = Math.random() * window.innerWidth;
            startY = window.innerHeight + 20;
            break;
        case 3: // Esquerda
            startX = -20;
            startY = Math.random() * window.innerHeight;
            break;
    }
    
    launchRocket(startX, startY, heartCenterX, heartCenterY);
}

// Lançar foguete de um ponto para outro
function launchRocket(startX, startY, destX, destY) {
    const rocket = document.createElement('div');
    rocket.classList.add('rocket');
    
    // Posição inicial
    rocket.style.left = startX + 'px';
    rocket.style.top = startY + 'px';
    
    // Calcular ângulo para rotação do foguete
    const angle = Math.atan2(destY - startY, destX - startX) * 180 / Math.PI - 90;
    rocket.style.transform = `rotate(${angle}deg)`;
    
    document.body.appendChild(rocket);
    
    // Cor aleatória para o foguete
    const colorIndex = Math.floor(Math.random() * colors.length);
    const color = colors[colorIndex];
    rocket.style.backgroundColor = color;
    
    // Animação do foguete
    const distance = Math.sqrt(Math.pow(destX - startX, 2) + Math.pow(destY - startY, 2));
    const duration = distance * 2; // Velocidade proporcional à distância
    
    animateRocket(rocket, startX, startY, destX, destY, duration, color);
}

function animateRocket(rocket, startX, startY, destX, destY, duration, color) {
    const startTime = performance.now();
    let lastSmokeTime = 0;
    
    function update(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);
        
        // Movimento com pequena curva
        const x = startX + (destX - startX) * progress;
        const y = startY + (destY - startY) * progress - Math.sin(progress * Math.PI) * 30;
        
        rocket.style.left = x + 'px';
        rocket.style.top = y + 'px';
        
        // Criar rastro de fumaça
        if (currentTime - lastSmokeTime > 20) {
            createSmoke(x, y);
            lastSmokeTime = currentTime;
        }
        
        if (progress < 1) {
            requestAnimationFrame(update);
        } else {
            // Chegou ao destino
            rocket.remove();
            
            // Criar explosão
            createExplosion(destX, destY, 15, color);
            
            // Mostrar 'TE AMO' sempre
            showTeAmo();
            
            // Efeito de pulsar no coração
            heart.style.transform = 'scale(1.2)';
            setTimeout(() => {
                heart.style.transform = 'scale(1)';
                heart.style.transition = 'transform 0.3s ease';
            }, 200);
        }
    }
    
    requestAnimationFrame(update);
}

function createSmoke(x, y) {
    const smoke = document.createElement('div');
    smoke.classList.add('smoke');
    
    // Posição ligeiramente aleatória ao redor do foguete
    const offsetX = (Math.random() - 0.5) * 6;
    const offsetY = (Math.random() - 0.5) * 6;
    
    smoke.style.left = (x + offsetX) + 'px';
    smoke.style.top = (y + offsetY) + 'px';
    
    document.body.appendChild(smoke);
    
    // Animar e remover a fumaça
    setTimeout(() => {
        smoke.style.opacity = '0';
        smoke.style.width = '10px';
        smoke.style.height = '10px';
        smoke.style.transition = 'all 0.8s ease';
        setTimeout(() => smoke.remove(), 800);
    }, 10);
}

function createExplosion(x, y, particleCount = 20, baseColor = null) {
    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.classList.add('firework');
        particle.style.left = x + 'px';
        particle.style.top = y + 'px';
        
        // Cor aleatória ou baseada na cor do foguete
        const color = baseColor || colors[Math.floor(Math.random() * colors.length)];
        particle.style.backgroundColor = color;
        particle.style.boxShadow = `0 0 10px ${color}, 0 0 20px ${color}`;
        
        document.body.appendChild(particle);
        
        const angle = Math.random() * Math.PI * 2;
        const distance = 20 + Math.random() * 60;
        const duration = 500 + Math.random() * 500;
        
        const destX = x + Math.cos(angle) * distance;
        const destY = y + Math.sin(angle) * distance;
        
        animateParticle(particle, x, y, destX, destY, duration);
    }
}

function animateParticle(particle, startX, startY, destX, destY, duration) {
    const startTime = performance.now();
    
    function update() {
        const elapsed = performance.now() - startTime;
        const progress = Math.min(elapsed / duration, 1);
        
        const x = startX + (destX - startX) * progress;
        const y = startY + (destY - startY) * progress;
        
        particle.style.left = x + 'px';
        particle.style.top = y + 'px';
        
        // Diminuir tamanho e opacidade
        const size = 5 * (1 - progress);
        particle.style.width = size + 'px';
        particle.style.height = size + 'px';
        particle.style.opacity = 1 - progress;
        
        if (progress < 1) {
            requestAnimationFrame(update);
        } else {
            particle.remove();
        }
    }
    
    requestAnimationFrame(update);
}

function showTeAmo() {
    // Centralizar o texto
    teAmo.style.left = (window.innerWidth / 2 - 100) + 'px';
    teAmo.style.top = (window.innerHeight / 2 - 30) + 'px';
    
    // Ativar a animação
    teAmo.classList.add('active');
    
    // Remover a classe após a animação
    setTimeout(() => {
        teAmo.classList.remove('active');
    }, 1500);
}

const menuToggle = document.getElementById('menu-toggle');
const menu = document.getElementById('menu');
menuToggle.addEventListener('click', () => {
    menu.classList.toggle('hidden');
}); 