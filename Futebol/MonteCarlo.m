a = function BuscaMCTS(M,S)%retorna a  melhor açao
continuaBusca = true;
while continuaBusca
	estadoFinal = false;
	a[] = percorreArvore(ultimoEstado);%percorre arvore de construção percorrendo os estados e guardando em um vetor
	tamanhoCaminho = Tamanho(Seq,Acoes);%Numero de acoes executadas na fase de construção
	if (estadoFinal == true)%Se acabar os estados da arvore, começa a simulação
		SimulaJogo(SeqAcoes);%Inicia a simulação
	end
	TamanhoSimulacao = Tamanho(Seq,Acoes)%Numero de acoes executadas na fase de simulação
	TabuleiroFinalJogo%executa acoes obtidas anteriormente
	Resultado = reward;%resultado obtido das execuções
	DesfazAcoes(TamanhoSimulacao-TabuleiroFinalJogo,SeqAcoes);
	DesfazAcoes(TabuleiroFinalJogo,SeqAcoes);
	if (horizon == 0)
		continuaBusca = false;
	end
end


a[] = function percorreArvore(S)
continuaCaminho = true;
while continuaCaminho
	if(S)% se o estado não possui filhos
		a[] = (GeraAcoes(NoCorrente));
		if(Vazio())%nao tem mais acoes
			estadoFinal = true;
		else
			expandeNo; %expandeNoAtual
		end
		continuaCaminho = false;
	end
	NoCorrente;
	Adiciona(CaminhoArvore,NoCorrente);
end

function SimulaJogo(SeqAcoes)
continua = true;
while continua
	NoCorrente = SimulaAcao(NoCorrente);
	if (NoCorrente == null)
		continua = false;
	end
	Adiciona(Acoes,NoCorrente);
end