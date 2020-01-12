function creditless(clip video, clip opening, clip ending, int "frameInicioAbertura", int "frameInicioEncerramento")
{
	frameInicioAbertura = frameInicioAbertura <= 0 ? Default(frameInicioAbertura, 0) : (frameInicioAbertura - 1)

	# Se o frame de inicio da abertura for <= 0, ele vai deixar o o frame em 0 pra evitar frame negativo.
	# Se a abertura comecar no meio do episodio, o trim vai acontecer 1 frame antes pq final do trim eh sempre no frame q vc escolheu + 1

	frameInicioEncerramento = frameInicioEncerramento <= 0 ? Default(frameInicioEncerramento, 0) : (frameInicioEncerramento - 1)

	# Se o encerramento for 0 ou null, significa que o encerramento nao vai ser substituido (ocorrem casos onde o encerramento tem cenas do episodio)

	qtdFramesEpisodio = video.FrameCount #pega o total de frames do episódio
	qtdFramesAbertura = opening.FrameCount #pega o total de frames da abertura
	qtdFramesEncerramento = ending.FrameCount #pega o total de frames do encerramento
	
	frameFinalAbertura = (frameInicioAbertura + qtdFramesAbertura + 1)
	frameFinalEncerramento = (frameInicioEncerramento + qtdFramesEncerramento + 1)
	
	################################################################
	# Validar se:												####
	#			- A abertura comeca no frame 0 ou depois.		####
	#			- Existe encerramento.							####
	#			- O episódio tem opening.                       ####
	################################################################

	temIntroducao = frameInicioAbertura > 0 ? true : false
	temEncerramento = frameInicioEncerramento != 0 ? true : false
	temAbertura = (isClip(opening)) ? true : false

	################################################################################## 
	# Faz ajustes no arquivo de abertura e encerramento para casos onde o arquivo da #
	# abertura creditless tem frame a mais ou a menos.                               #
	# Caso a abertura tenha MUITA diferenca, precisa mandar ela trimmada pro script. #
	##################################################################################

	if (temIntroducao == true && temEncerramento == true) {		
		introducao = video.trim(0, frameInicioAbertura)
		InicioDoepisodio = video.trim(frameFinalAbertura, frameInicioEncerramento)
		previa = video.trim(frameFinalEncerramento, qtdFramesEpisodio)
		return introducao + opening + InicioDoepisodio + ending + previa
			
	} else if (temIntroducao == false && temEncerramento == true) {
		InicioDoepisodio = video.trim(frameFinalAbertura, frameInicioEncerramento)
		previa = video.trim(frameFinalEncerramento, qtdFramesEpisodio)

		return opening + InicioDoepisodio + ending + previa		

	} else if (temIntroducao == true && temEncerramento == false) {
		introducao = video.trim(0, frameInicioAbertura)
		InicioDoepisodio = video.trim(frameFinalAbertura, frameInicioEncerramento)
		
		return introducao + opening + InicioDoepisodio

	## TODO - Levar as validacoes de tipo de parametros la pra cima, já que é impossível passar null, e o tipo var retorna erro no FrameCount()
	#} else if (temAbertura == false && temEncerramento == true) {				
	#	previa = video.trim(frameFinalEncerramento, qtdFramesEpisodio)
	#	return video + ending + previa	
	} else {
		return String("PORRA")
	}
	
}
