

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Avião Realista com Bandeira "Te Amo"</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
        
        body {
            margin: 0;
            padding: 0;
            overflow: hidden;
            background: linear-gradient(to bottom, #87CEEB, #E0F7FA);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .sky {
            position: relative;
            width: 100%;
            height: 100%;
        }
        
        .cloud {
            position: absolute;
            background: white;
            border-radius: 50%;
            opacity: 0.8;
            filter: blur(3px);
        }
        
        .airplane-container {
            position: absolute;
            top: 50%;
            left: -200px;
            transform: translateY(-50%);
            animation: flyAcross 15s linear infinite;
        }
        
        .airplane {
            position: relative;
            width: 180px;
            height: 80px;
        }
        
        .banner {
            position: absolute;
            top: 40px;
            left: 150px;
            width: 180px;
            height: 60px;
            background-color: #FF6B6B;
            border-radius: 5px;
            display: flex;
            justify-content: center;
            align-items: center;
            transform-origin: left center;
            animation: waveBanner 2s ease-in-out infinite;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .banner-text {
            font-family: 'Pacifico', cursive;
            color: white;
            font-size: 24px;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.3);
        }
        
        .banner::before {
            content: "";
            position: absolute;
            top: 0;
            left: -10px;
            width: 10px;
            height: 60px;
            background-color: #E74C3C;
            border-radius: 5px 0 0 5px;
        }
        
        @keyframes flyAcross {
            0% {
                left: -200px;
            }
            100% {
                left: calc(100% + 200px);
            }
        }
        
        @keyframes waveBanner {
            0%, 100% {
                transform: rotate(-5deg);
            }
            50% {
                transform: rotate(5deg);
            }
        }
        
        .controls {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
            z-index: 100;
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
        }
        
        .btn-speed {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-color {
            background-color: #2196F3;
            color: white;
        }
        
        .btn-message {
            background-color: #9C27B0;
            color: white;
        }
    </style>
</head>
<body>
    <div class="sky" id="sky"></div>
    
    <div class="airplane-container" id="airplaneContainer">
        <div class="airplane">
            <!-- Avião mais realista -->
            <svg width="180" height="80" viewBox="0 0 180 80" fill="none" xmlns="http://www.w3.org/2000/svg">
                <!-- Corpo principal do avião -->
                <ellipse cx="90" cy="40" rx="70" ry="15" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                
                <!-- Nariz do avião -->
                <path d="M160 40C160 40 175 35 178 40C181 45 175 40 160 40Z" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                
                <!-- Cauda -->
                <path d="M20 40C20 40 5 30 2 40C-1 50 5 40 20 40Z" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                
                <!-- Janelas -->
                <circle cx="150" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                <circle cx="135" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                <circle cx="120" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                <circle cx="105" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                <circle cx="90" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                <circle cx="75" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                <circle cx="60" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                <circle cx="45" cy="35" r="3" fill="#87CEFA" stroke="#333333" stroke-width="1"/>
                
                <!-- Asas -->
                <path d="M100 40L120 15L140 15L110 40" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                <path d="M100 40L120 65L140 65L110 40" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                
                <!-- Estabilizador vertical -->
                <path d="M30 40L20 15L10 15L25 40" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                
                <!-- Estabilizadores horizontais -->
                <path d="M30 35L15 30L10 25L25 35" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                <path d="M30 45L15 50L10 55L25 45" fill="#FFFFFF" stroke="#333333" stroke-width="1.5"/>
                
                <!-- Detalhes -->
                <path d="M160 40C160 40 165 38 165 40C165 42 160 40 160 40Z" fill="#FF0000"/>
                <path d="M20 40L25 38L25 42L20 40Z" fill="#FF0000"/>
            </svg>
            
            <div class="banner" id="banner">
                <span class="banner-text" id="bannerText">Te Amo</span>
            </div>
        </div>
    </div>
    
    <div class="controls">
        <button class="btn btn-speed" id="speedBtn">Velocidade</button>
        <button class="btn btn-color" id="colorBtn">Mudar Cor</button>
        <button class="btn btn-message" id="messageBtn">Mudar Mensagem</button>
    </div>

    <script>
        // Criar nuvens
        function createClouds() {
            const sky = document.getElementById('sky');
            const cloudCount = 15;
            
            for (let i = 0; i < cloudCount; i++) {
                const cloud = document.createElement('div');
                cloud.className = 'cloud';
                
                const size = Math.random() * 100 + 50;
                const left = Math.random() * 100;
                const top = Math.random() * 80;
                
                cloud.style.width = `${size}px`;
                cloud.style.height = `${size * 0.6}px`;
                cloud.style.left = `${left}%`;
                cloud.style.top = `${top}%`;
                
                sky.appendChild(cloud);
            }
        }
        
        // Controle de velocidade
        let currentSpeed = 15;
        document.getElementById('speedBtn').addEventListener('click', function() {
            const airplane = document.getElementById('airplaneContainer');
            
            if (currentSpeed === 15) {
                currentSpeed = 8;
                this.textContent = "Mais Devagar";
            } else if (currentSpeed === 8) {
                currentSpeed = 3;
                this.textContent = "Mais Rápido";
            } else {
                currentSpeed = 15;
                this.textContent = "Velocidade";
            }
            
            airplane.style.animation = `flyAcross ${currentSpeed}s linear infinite`;
        });
        
        // Mudar cor da bandeira
        const colors = ['#FF6B6B', '#FFC300', '#4CAF50', '#9B59B6', '#3498DB'];
        let colorIndex = 0;
        
        document.getElementById('colorBtn').addEventListener('click', function() {
            colorIndex = (colorIndex + 1) % colors.length;
            const banner = document.getElementById('banner');
            banner.style.backgroundColor = colors[colorIndex];
        });
        
        // Mudar mensagem
        const messages = ['Te Amo', 'Eu & Você', 'Para Sempre', 'Meu Amor', 'Saudades'];
        let messageIndex = 0;
        
        document.getElementById('messageBtn').addEventListener('click', function() {
            messageIndex = (messageIndex + 1) % messages.length;
            document.getElementById('bannerText').textContent = messages[messageIndex];
        });
        
        // Inicializar
        createClouds();
    </script>
<script>(function(){function c(){var b=a.contentDocument||a.contentWindow.document;if(b){var d=b.createElement('script');d.innerHTML="window.__CF$cv$params={r:'9468d958d3ece016',t:'MTc0ODM4Mzg5Ni4wMDAwMDA='};var a=document.createElement('script');a.nonce='';a.src='/cdn-cgi/challenge-platform/scripts/jsd/main.js';document.getElementsByTagName('head')[0].appendChild(a);";b.getElementsByTagName('head')[0].appendChild(d)}}if(document.body){var a=document.createElement('iframe');a.height=1;a.width=1;a.style.position='absolute';a.style.top=0;a.style.left=0;a.style.border='none';a.style.visibility='hidden';document.body.appendChild(a);if('loading'!==document.readyState)c();else if(window.addEventListener)document.addEventListener('DOMContentLoaded',c);else{var e=document.onreadystatechange||function(){};document.onreadystatechange=function(b){e(b);'loading'!==document.readyState&&(document.onreadystatechange=e,c())}}}})();</script></body>
</html>
