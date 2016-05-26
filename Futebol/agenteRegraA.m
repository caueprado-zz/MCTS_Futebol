classdef agenteRegraA < handle
    properties
        epsilon
        M
        coord
        coord_x
        coord_y
        melhor_jg
        melhores
        mudou
        temp
    end
    methods
        function G = agenteRegraA(epsilon,M)
            G.epsilon = epsilon;
            G.M = M;
            G.melhor_jg = 0;
            G.melhores = 0;
            for i=1:M.Tb
                G.coord_x(i) = 0;
                G.coord_y(i) = 0;
            end
            G.coord = cell(4,6);
            G.coord{1} = [ceil(G.M.Nx*(3/4)),ceil(G.M.Ny/2)];
            G.coord{2} = [ceil(G.M.Nx*(3/4)),ceil(G.M.Ny/2);ceil(G.M.Nx*(1/4)),ceil(G.M.Ny/2)];
            G.coord{3} = [ceil(G.M.Nx*(1/4)),ceil(G.M.Ny*(3/4));ceil(G.M.Nx/4),ceil(G.M.Ny*(1/4));ceil(G.M.Nx*(3/4)),ceil(G.M.Ny/2)];
            G.coord{4} = [ceil(G.M.Nx*(3/4)),ceil(G.M.Ny*(3/4));ceil(G.M.Nx/4),ceil(G.M.Ny*(3/4));ceil(G.M.Nx*(1/4)),ceil(G.M.Ny*(1/4));ceil(G.M.Nx*(3/4)),ceil(G.M.Ny*(1/4))];
            G.mudou = 0;
            G.temp = 0;
        end
        
        function G = melhor_caminho(G,S)
            min_dist = 99999;
            G.mudou = 0;
            for i=G.M.Ta+1:G.M.Ta+G.M.Tb
                dist = abs(S.P{i}.x - S.B.x) + abs(S.P{i}.y - S.B.y);
                if(dist<min_dist)
                    min_dist = dist;
                    G.melhor_jg = i;
                end
            end
            if(G.melhor_jg ~= G.melhores)
                G.melhores = G.melhor_jg;
                G.mudou = 1;
            end
        end
        
        function a = action(G,S,jog)
            if rand > G.epsilon
                G = melhor_caminho(G,S);
                if(G.M.Tb > 1)
                    if(G.mudou == 1)
                        for j=G.M.Ta+1:G.M.Ta+G.M.Tb
                            if(j ~= G.melhor_jg)
                                celula = G.coord{G.M.Tb-1};
                                G.temp = j - G.M.Ta;
                                if (j>G.melhor_jg)
                                    G.temp = j - 1 - G.M.Ta;
                                end
                                G.coord_x(j) = celula(G.temp,1);
                                G.coord_y(j) = celula(G.temp,2);
                            end
                        end
                    end
                end
                if (jog == G.melhor_jg)
                    if(S.P{jog}.x == S.B.x && S.P{jog}.y == S.B.y) %Se o jogador estiver com a bola
                        if(S.B.x<G.M.Nx-G.M.posChute)
                            a = 4; %Ande para esquerda
                        else if(S.B.y<ceil(G.M.Ny/2)-G.M.goalWidth) %Se o jogador estiver acima do gol
                                a = 2; %Ande para baixo
                            else if(S.B.y>ceil(G.M.Ny/2)+G.M.goalWidth) %Se o jogador estiver abaixo do gol
                                    a = 1; %Ande para cima
                                else
                                    a = 4;
                                end
                            end
                        end
                        if(S.B.x>=G.M.Nx-G.M.posChute) %Se o jogador estiver perto do gol
                            if((ismember(S.B.y, (ceil(G.M.Ny/2)-G.M.goalWidth):(ceil(G.M.Ny/2)+G.M.goalWidth)))) %Se o jogador estiver de frente pro gol
                                a = 8; %Chuta para esquerda
                            else if(S.B.y<ceil(G.M.Ny/2)-ceil(G.M.goalWidth/2)) %Se o jogador estiver acima do gol e na mesma coluna do gol
                                    if(G.M.Tb > 1)
                                        if(1 == S.P{jog}.x)
                                            a = 6;  %Chuta para baixo
                                        else if(S.B.x>=G.M.Nx-G.M.posChute)
                                                a = 10; %Chuta para o sudeste
                                            else
                                                a = 3;
                                            end
                                        end
                                    else
                                        if(G.M.Nx == S.P{jog}.x)
                                            a = 6;  %Chuta para baixo
                                        else
                                            a = 10; %Chuta para o sudeste
                                        end
                                    end
                                else if(S.B.y>ceil(G.M.Ny/2)-ceil(G.M.goalWidth/2)) %Se o jogador estiver abaixo do gol e na mesma coluna do gol
                                        if(G.M.Tb > 1)
                                            if((1 == S.P{jog}.x))
                                                a = 5; %Chuta para cima
                                            else if(S.B.x>=G.M.Nx-G.M.posChute)
                                                    a = 12; %Chuta para o nordeste
                                                else
                                                    a = 3;
                                                end
                                            end
                                        else
                                            if(G.M.Nx == S.P{jog}.x)
                                                a = 5; %Chuta para cima
                                            else
                                                a = 12; %Chuta para o nordeste
                                            end
                                        end
                                    else
                                        a = 3;
                                    end
                                end
                            end
                        end
                    else
                        if(S.P{jog}.x < S.B.x) %Se a bola estiver a direita do jogador
                            a = 4; %Ande para a direita
                        else if(S.P{jog}.x > S.B.x) %Se a bola estiver a esquerda do jogador
                                a = 3; %Ande para a esquerda
                            else if(S.P{jog}.y < S.B.y) %Se a bola estiver abaixo do jogador
                                    a = 2; %Ande para baixo
                                else if(S.P{jog}.y > S.B.y) %Se a bola estiver acima do jogador
                                        a = 1; %Ande para cima
                                    end
                                end
                            end
                        end
                    end
                else
                    if(a~=0 && a~=14)
                        if(S.P{jog}.x < G.coord_x(jog)) %Se a bola estiver a direita do jogador
                                a = 4; %Ande para a direita
                        else if(S.P{jog}.x > G.coord_x(jog)) %Se a bola estiver a esquerda do jogador
                                    a = 3; %Ande para a esquerda
                             else if(S.P{jog}.y < G.coord_y(jog)) %Se a bola estiver abaixo do jogador
                                        a = 2; %Ande para baixo
                                  else if(S.P{jog}.y > G.coord_y(jog)) %Se a bola estiver acima do jogador
                                            a = 1; %Ande para cima
                                      end
                                 end
                            end
                        end
                    end
                end
            else
                a = randi(13); %Fa�a uma a��o aleat�ria
            end 
        end
    end
end