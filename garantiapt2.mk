

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coração Neon com Foguetes</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background-color: #0f0f1a;
            overflow: hidden;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .heart {
            position: relative;
            width: 200px;
            height: 200px;
            cursor: pointer;
            transition: transform 0.3s ease;
            z-index: 100;
        }

        .heart:hover {
            transform: scale(1.1);
        }

        .heart-svg {
            fill: transparent;
            stroke: #ff00ff;
            stroke-width: 5;
            filter: drop-shadow(0 0 10px #ff00ff) drop-shadow(0 0 20px #ff00ff);
            animation: neon 1.5s ease-in-out infinite alternate;
        }

        @keyframes neon {
            from {
                filter: drop-shadow(0 0 5px #ff00ff) drop-shadow(0 0 10px #ff00ff);
            }
            to {
                filter: drop-shadow(0 0 10px #ff00ff) drop-shadow(0 0 20px #ff00ff) drop-shadow(0 0 30px #ff00ff);
            }
        }

        .rocket {
            position: absolute;
            width: 6px;
            height: 20px;
            background: linear-gradient(to top, #ff3300, #ffcc00);
            border-radius: 50% 50% 0 0;
            pointer-events: none;
            z-index: 10;
            transform-origin: bottom center;
        }

        .rocket::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: -4px;
            width: 14px;
            height: 14px;
            background: radial-gradient(circle, rgba(255,255,0,0.8) 0%, rgba(255,153,0,0.4) 60%, rgba(255,0,0,0) 100%);
            border-radius: 50%;
            animation: flicker 0.1s infinite alternate;
        }

        @keyframes flicker {
            0% { opacity: 0.7; transform: scale(0.8); }
            100% { opacity: 1; transform: scale(1.2); }
        }

        .smoke {
            position: absolute;
            width: 4px;
            height: 4px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.6);
            pointer-events: none;
            z-index: 5;
        }

        .firework {
            position: absolute;
            width: 5px;
            height: 5px;
            border-radius: 50%;
            pointer-events: none;
            z-index: 10;
        }

        .te-amo {
            position: absolute;
            font-family: 'Arial', sans-serif;
            font-weight: bold;
            color: #ffffff;
            text-shadow: 0 0 10px #ff00ff, 0 0 20px #ff00ff;
            opacity: 0;
            font-size: 0px;
            transition: all 0.5s ease;
            z-index: 20;
        }

        .te-amo.active {
            opacity: 1;
            font-size: 48px;
            animation: explode 1s ease-out forwards;
        }

        @keyframes explode {
            0% {
                transform: scale(0.1);
                opacity: 0;
            }
            50% {
                opacity: 1;
            }
            100% {
                transform: scale(1.2);
                opacity: 0;
            }
        }

        .stars {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .star {
            position: absolute;
            background-color: white;
            border-radius: 50%;
            opacity: 0.5;
            animation: twinkle 3s infinite alternate;
        }

        @keyframes twinkle {
            0% { opacity: 0.2; }
            100% { opacity: 0.8; }
        }
    </style>
</head>
<body>
    <div class="stars" id="stars"></div>
    <div class="heart" id="heart">
        <svg class="heart-svg" viewBox="0 0 512 512">
            <path d="M462.3 62.6C407.5 15.9 326 24.3 275.7 76.2L256 96.5l-19.7-20.3C186.1 24.3 104.5 15.9 49.7 62.6c-62.8 53.6-66.1 149.8-9.9 207.9l193.5 199.8c12.5 12.9 32.8 12.9 45.3 0l193.5-199.8c56.3-58.1 53-154.3-9.8-207.9z"></path>
        </svg>
    </div>
    <div class="te-amo" id="teAmo">TE AMO</div>

    <script>
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
                    
                    // Mostrar "TE AMO" ocasionalmente
                    if (Math.random() > 0.5) {
                        showTeAmo();
                    }
                    
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
    </script>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'9468e900f1bbd5e8',t:'MTc0ODM4NDUzNy4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script></body>
</html>
