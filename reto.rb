=begin
Saludar
nombre de jugador?
crear jugador, propieades

1. nombre
2. intentos
3. AciertosJugar
solicitar preguntas .. crear append
revolver
1.mientras ...intentos < 5 || acierto <append
2. preguntar.... si
3. correcto, acierto+++,  ir a 2
4. wrong, intento++  ir a 2

6. aciertos = append.. felicitaciones!!!!
7. else mejor suerte para la proxima
=end
class Jugador
  attr_accessor :nombre, :intentos, :aciertos
  def initialize nombre
    @nombre = nombre
    @intentos = 0
    @aciertos = 0
  end
  def nombre
    @nombre
  end
  def intentos
    @intentos
  end
  def aciertos
    @aciertos
  end
end

class Preguntas
  def initialize
    @line_num = 0
    @revolver= []
    @preguntas = []
  end
  def preguntas
    text=File.open('preguntas.txt').read
    text.gsub!(/\r\n?/, "\n")
    text.each_line do |line|
      @preguntas[@line_num] = line.to_str.strip!
      @line_num += 1
    end
    @preguntas
  end
  def cuestionario
    @revolver=(0..(@line_num/2)-1).map{|i| i*2}
  end
  def revolver
    @revolver.shuffle!

  end
  def line_num
    @line_num
  end
  def preguntar
    @preguntar = @revolver.shift
  end
  def pregunta
    @pregunta = @preguntas[@preguntar]
  end
  def respuesta
    j = 0
    j = @preguntar + 1
    @respuesta = @preguntas[j]
  end
end

puts "Para empezar diganos cual es su nombre..."
#STDOUT.flush
nombre = gets.chomp

player = Jugador.new(nombre)

puts "Bienvenido a reto 5 #{player.nombre}"
quiz = Preguntas.new
quiz.preguntas # cargar preguntas
quiz.cuestionario #listar preguntas
puts "Para jugar, solo ingresa el termino correcto para cada una de las definiciones, Listo? Vamos!"


quiz.revolver # random preguntas
juego = "s"
while juego.downcase != "n"
  print "Desea continuar(S/n)"
  if gets.chomp!.downcase == "n"
    break
  end
  quiz.preguntar # nueva pregunta

  while player.aciertos < quiz.line_num/2 && player.intentos < 5

    puts
    print "Definicion: "
    puts quiz.pregunta
    adivina = ""
    print "Tu respuesta: "
    r= quiz.respuesta
    adivina = gets.chomp!

    if adivina.downcase == r.downcase
      puts "Correcto"
      player.aciertos +=1
      quiz.preguntar

    else
      puts "Upss , intenta de nuevo "
      player.intentos += 1
    end
    puts "#{player.nombre} tienes: #{player.aciertos} Aciertos y #{player.intentos} Intentos "
  end

  puts
  if player.aciertos == 12
    puts "Felicitaciones"
  elsif player.intentos == 5
    puts "Perdiste, no te desanimes, intenta otra vez"
  end
  print "Volver a jugar (S/n)?"
  juego= gets.chomp!.downcase
  if juego != "n"
    puts "Empecemos nuevamente"
    puts
    player.aciertos= 0
    player.intentos= 0
    quiz.cuestionario
    quiz.revolver
    quiz.preguntar
  end

end
puts "vuelve pronto!"
