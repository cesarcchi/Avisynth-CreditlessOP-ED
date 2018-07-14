function creditless(clip video, clip opening, clip ending, int "ops", int "eds")
{
	ops = default(ops, 0)	#zera o valor da variável caso n tenha sido declarada no script (ajuda caso seja só a abertura)
	eds = default(eds,0)
	vLenght = video.FrameCount #pega o total de frames do episódio
	oLenght = opening.FrameCount #pega o total de frames da abertura
	eLenght = ending.FrameCount #pega o total de frames do encerramento
	
	################################################
	#                   gambiarras                 #
	################################################
	opt = (ops <= 0) ? ops : (ops - 1)		#Verifica se a abertura começa no frame 0 (inicio do episódio) ou no decorrer dele. Caso comece no decorrer do epi, o trim acontece 1 frame antes da abertura começar.
	edt = (eds <= 0) ? eds : (eds - 1)
	ocut = (ops + oLenght)					# soma o inicio da op + tamanho pra calcular o final para o trimm
	ecut = (eds + eLenght)					# soma o inicio da ed + tamanho pra calcular o final para o trimm
	conts = (ocut + 1)
	prevs = (ecut + 1)
	
	################################################################
	##             TRIM no arquivo principal de video             ##
	################################################################
	
	intro = video.trim(0,opt) 			# 0 até o frame inicial da abertura -1
	opsong = opening.trim(ops,ocut)		#
	o = opening.trim(0,oLenght)
	content = video.trim(conts,edt)		# corta o episódio entre o fim da abertura e o começo do encerramento
	e = ending.trim(0,eLenght)
	edsong = ending.trim(eds,ecut)		#
	previa = video.trim (prevs,vLenght)	#
	
	
	videofinal = intro+o+opsong+content+e+edsong+previa
	return videofinal
}
