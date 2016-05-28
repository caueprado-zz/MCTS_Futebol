classdef ArvoreMonteCarlo < handle
    properties
        M
        S
        estados
        reward
        acaoEstado
		filhos
        acoes
        melhorNo
    end
    methods
        function MC = ArvoreMonteCarlo(S,M)

        MC.estados{end+1} = [{S.fatora()} {[]} {0} {0}];%estado atual
        MC.filhos = 0;%indica quantidade de nÛs filhos
        MC.M = M;%inicializa o problema utilizado nas funcoes
        MC.S = S;
        
%         for i=0:1000
            %Selecao - possiveis acoes a partir do estado S
            no=MC.selecao(S);

%             value = MC.rollout(no);
%         end
%        MC.acoes = selecao(agente,MC.estados);
%
%      if size(acoes) > size(MC.filhos)
	
       % else

        %end

       % expande();
%
        end
        
        function no = selecao(MC,S)
            aNew = [];
            aOld = aNew;
            sNewA = 0;
            sNewB = 0;
            sOldA = sNewA;
            sOldB = sNewB;
        
            sNewA = S.fatora();
            sNewB = S.fatoraB();

            
            actions = MC.movimentos(S);
            MC.S.move([MC.M.Ta randi(size(actions))]);
            
            aNew(MC.M.Ta+1:end) = EscolheAcaoB(MC.M.Tb,agenteB,sOldB,aOld(MC.M.Ta+1:end),MC.reward,sNewB,notFirst,horizon);
            
            estados(end+1) = [{S.fatora()} {actions} {0} {0}];
            %expansao - verifica o estado atual e quantidade de filhos
            if(size(actions)>MC.filhos)
                no=MC.expande(S,actions);
            else
                no=UCT(S,1.4);
            end
        end
        
        %Calculo UCB para verificar melhor para expandir        
        function valor = UCT(MC,S,gamma)
        valor = 0;
%         for (Node child in current.children)
              %Calculo do melhor nÛ
%             valor = ((double)child.value / (double)child.visits) + C * Math.Sqrt((2.0 * Math.Log((double)current.visits)) / (double)child.visits);
% 
%             if (valor > MC.melhorNo)
%                 bestChild = child;
%                 MC.melhorNo = valor;
%             end
%         end

        end
        
        function actions = movimentos(MC,S)
            %B.x, B.y, B_direct+1, B_speed+1, P{1}.x, P{1}.y, P{2}.x, P{2}.y
            actions=[];
            % verificar se a bola esta com jogador
            if(S.P{2}.x == S.B.x && S.P{2}.y == S.B.y)
            %agente chuta para N (5), S (6), O (7), L  (8), NE (9), SE (10), NO
            %(11), SO (12)
            %agente est√° com a bola e n√£o se encontra nos limites do campo
                if(MC.M.Ny-S.P{2}.y>0 && MC.M.Ny-S.P{2}.y<7) 
                    actions(end+1) = 2;%andar para baixo
                    actions(end+1) = 6;%chutar para baixo
                    actions(end+1) = 1;%andar para  cima
                    actions(end+1) = 5;%chutar para  cima
                    if(MC.M.Nx-S.P{2}.x<7)%n√£o esta no fim do campo
                        actions(end+1) = 3;%andar para  
                        actions(end+1) = 7;%chutar para  
                    end
                    if(MC.M.Nx-S.P{2}.x>3)%n√£o esta no inicio do campo
                        actions(end+1) = 4;
                        actions(end+1) = 8;
                    end
                elseif(MC.M.Ny-S.P{2}.y ==3)
                    actions(end+1) = 1;
                    actions(end+1) = 5;
                if(MC.M.Nx-S.P{2}.x<7)
                    actions(end+1) = 3;
                    actions(end+1) = 7;
                end
                if(MC.M.Nx-S.P{2}.x>3)
                    actions(end+1) = 4;
                    actions(end+1) = 8;
                end
                %Se o jogador ja est√É¬° no limite inimigo
                elseif(MC.M.Ny-S.P{2}.y==7)
                    actions(end+1) = 2;
                    actions(end+1) = 6;
                    if(MC.M.Nx-S.P{2}.x<7)
                        actions(end+1) = 3;
                        actions(end+1) = 7;
                    end
                    if(MC.M.Nx-S.P{2}.x>3)
                        actions(end+1) = 4;
                        actions(end+1) = 8;
                    end
                end 
            else %se a bola nao esta com jogador
                if(S.B.x==9 && (S.B.y<=5 && S.B.y>=3))
                    return;
                end
                if(S.B.x==2 && (S.B.y<=5 && S.B.y>=3))
                    return;
                end
            actions(end+1) = 13;
            if(S.P{1}.x-S.P{2}.x<=-1)  
                actions(end+1) = 3;
            end
            if(S.P{1}.y-S.P{2}.y<=-1)
                actions(end+1) = 2;
            end
            if(S.P{1}.y-S.P{2}.y>=1)
                actions(end+1) = 1; 
            end
            end
            
        end

%   recebe o no para expans„o verifica qual o melhor nı para expandir
    function no = expande(MC,actions)
    no = MC.estados;
    
    for i=1:size(actions)
        acao = actions(i);
        bestMove = acao;
    end
    
%    MC.estados(end+1) = MC.S.fatora();
    end

    function rollback(MC,S)
    while J.timer>0
            if horizon == 0
                S.espalhamentoGoal(MC.M,true);
                notFirst = false;
                horizon = MC.M.horizon;
                if (exibe)
                    showGame(S, MC.M, J);
                end
            end
        
            horizon = horizon-1;
        
            % escolhe acao para cada jogador
            aOld = aNew;
            sOldA = sNewA;
            sOldB = sNewB;
        
            sNewA = S.fatora();
            sNewB = S.fatoraB();

            aNew(1:MC.M.Ta) = EscolheAcaoA(MC.M.Ta,agenteA,sOldA,aOld(1:MC.M.Ta),MC.reward,sNewA,notFirst,horizon);
            aNew(MC.M.Ta+1:end) = EscolheAcaoB(MC.M.Tb,agenteB,sOldB,aOld(MC.M.Ta+1:end),MC.reward,sNewB,notFirst,horizon);
		
            notFirst = true;

            MC.reward = S.move(aNew);
            MC.recompensa(p,tempopartida) = MC.reward;%recompensa para esse ti
  
            J.placarA=J.placarA+max(MC.reward,0);%Placar de A, 
            J.placarB=J.placarB+max(-MC.reward,0);%Placar de B
            J.timer=J.timer-1;

            if (exibe)
                showGame(S, MC.M, J);
            end

            if mod(J.timer,nIterShow) == 0
                [p J.timer/J.total]
                full([sum(J.placarA) sum(J.placarB)])'
            end
    end

    end
    
    end%methods
end%classdef