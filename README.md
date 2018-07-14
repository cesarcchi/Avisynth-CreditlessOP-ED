# Avisynth-CreditlessOP-ED

Script para facilitar a edição de episódios com abertura/encerramento sem créditos.

Exemplo:

a = DirectShowSource("Video Principal.avi")
b = DirectShowSource("Creditless OP.avi")
c = DirectShowSource("Creditless ED.avi")

creditless(a,b,c,frame_de_inicio_da_abertura,frame_de_início_do_encerramento)

O script vai recortar os frames da abertura e encerramento e adicionar os vídeos das creditless no lugar deles.
