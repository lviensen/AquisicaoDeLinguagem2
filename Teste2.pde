import processing.video.*;

import ddf.minim.*;
import ddf.minim.analysis.*;

int mouse = 0;   //Contador para controlar as interações com o mouse
PImage play;
PImage menu;
PImage iniciar;
PImage repetir;
PImage finalizar;
PImage carregando;
PImage perfeito;
PImage otimo;
PImage muitobom;
PImage bom;
PImage ruim;
PImage ouvindo;
PImage resultado;
Movie saudacaocatalao;
Movie saudacaofranca;
Movie catalaofrase;
Movie francafrase;
boolean videocatalaoplay = false;
boolean videofrancaplay = false;
boolean videocatalaofrase = false;
boolean videofrancafrase = false;
boolean falarC = false;
boolean falarF = false;
boolean videofinal = false;
boolean videofraseC = false;
boolean videofraseF = false;
float levelCatalaoright = 0;
float levelFranca = 0;
float levelFrancaright = 0;
float levelFrancaleft = 0;
float levelEntradaFrancaright = 0;
float levelEntradaFrancaleft = 0;
float levelEntradaCatalao = 0;
float levelEntradaCatalaoleft = 0;
float levelEntradaCatalaoright = 0;
float levelCatalaoleft = 0;
float levelEntradaFranca = 0;
float levelCatalao = 0;
import ddf.minim.*;   //importa biblioteca para utilização de áudio e seus recursos
AudioRecorder recorder;
Minim minim;
AudioInput in;  //Modo para capturar entrada de áudio
AudioPlayer audiocatalaofrase;
AudioPlayer audiofrancafrase;
AudioPlayer audioTeste;
int initialTime;
int initialTimeF;
boolean geraImagem = false;
boolean geraImagemFranca = false;

BeatDetect beat;
float eRadius;

void setup()
{
  size(1019, 573);
  background(255);
  play = loadImage("AL001.png");  
  image(play, 0, 0);   //Programa é inicializado com a imagem "play"
  menu = loadImage("AL002.png");
  iniciar = loadImage("AL003.png");
  finalizar = loadImage("AL006.png");
  carregando = loadImage("carregando.png");
  perfeito = loadImage("perfeito.png");
  otimo = loadImage("otimo.png");
  muitobom = loadImage("muitobom.png");
  bom = loadImage("bom.png");
  ruim = loadImage("ruim.png");
  ouvindo = loadImage("Microfone.png");
  resultado = loadImage("AL005.png");
  saudacaocatalao = new Movie(this, "saudacaocatalao.mov");
  saudacaofranca = new Movie(this, "saudacaofranca.mp4");
  catalaofrase = new Movie(this, "catalaofrase.mp4");
  francafrase = new Movie(this, "videofrasefranca.mp4");
  repetir = loadImage("AL004.png");
  minim = new Minim(this);
  audiocatalaofrase = minim.loadFile("audiocatalaofrase.mp3", 1024);
  in = minim.getLineIn();
  audiofrancafrase = minim.loadFile("audiofrancafrase.mp3", 2048);
  
  minim = new Minim(this);
  
  beat = new BeatDetect();  
  ellipseMode(RADIUS);
  eRadius = 20;
  
}
void draw(){
  //println("mouseX:"+mouseX+"   mouseY:"+mouseY);
  if(mouse == 2   && videocatalaoplay ) //Executa vídeo Catalão  de Entrada
  {
        image(iniciar, 0, 0);
        saudacaocatalao.play();
        image(saudacaocatalao, 165, 30, 690, 410);     
  }
  else if(mouse == 2   && videofrancaplay)  //Executa vídeo França de entrada
  {
      image(iniciar, 0, 0);
      saudacaofranca.play();
      image(saudacaofranca, 165, 30, 690, 410);
    
  }
  if(mouse == 3 && videofraseC)  //Executa vídeo com a frase em Catalão
  {
          image(iniciar, 0, 0);
          catalaofrase.play();
          image(catalaofrase, 165, 30, 690, 410);
  }
  if(mouse == 3 && videofraseF)  //Executa vídeo com a frase em Francês
  {
          image(iniciar, 0, 0);
          francafrase.play();
          image(francafrase, 165, 30, 690, 410);
  }
  
  else if(mouse == 4)
  {
    
    if(videocatalaoplay)            
        entradadeaudiocatalao();
    
    else if(videofrancaplay)
        entradadeaudiofranca();
               
  }
  if(mouse == 4 && videocatalaofrase)
  {
        
        if(audiocatalaofrase.isPlaying() && falarC == false){
          image(repetir, 0, 0, 1019, 573);
          //catalaofrase.play();
          catalaofrase.volume(0);
          image(catalaofrase, 165, 30, 690, 410);
        }
        for(int i = 0; i < audiocatalaofrase.bufferSize() - 1; i++)     //Audio do programa 
        {        
            levelCatalaoleft = levelCatalaoleft + audiocatalaofrase.left.level(); //Obtém a soma final do nível de todo o áudio 
            levelCatalaoright = levelCatalaoright + audiocatalaofrase.right.level();
        }
        levelCatalao = levelCatalaoright + levelCatalaoleft;
        //System.out.println("levelCatalao: "+levelCatalao);
       
       
       if(audiocatalaofrase.isPlaying() == false && falarC) 
        {
            image(repetir,0,0, 1019, 573);
            int initialTime2 = millis();
            int fim = initialTime - initialTime2;
            int seg = fim /1000;
            //println("Fim:  "+seg);
            if(seg >= -1 )
            {
                image(ouvindo, 0, 0);
               for(int i = 0; i < in.bufferSize() - 1; i++)  //Entrada de áudio
               {        
                   levelEntradaCatalaoright = levelEntradaCatalaoright + in.right.level();
                   levelEntradaCatalaoleft = levelEntradaCatalaoleft + in.left.level();  //Obtém a soma final do nível de todo o áudio de entrada
               }
            }
            levelEntradaCatalao = levelEntradaCatalaoleft + levelEntradaCatalaoright;
            //System.out.println("levelEntradaCatalao: "+levelEntradaCatalao);
            float mediaLevel = (levelCatalao - levelEntradaCatalao)/1000;  //Obtém a difernça de nível entre os dois áudios
            int med = int(mediaLevel); //Converte a variavel mediaLevel(float) a uma variável med(int)
            //System.out.println("Media: "+med);
            if(seg<= -2 && seg >= -3)   //Carrega a imagem "carregando" por 2 segundos
            {
              image(carregando, 0, 0, 1019, 573);
              geraImagem = true;
            }
            else if(seg <= -4 && geraImagem && seg >=-7)  
            {  //Faz as comparações e gera uma imagem de resultado 
              
              if(med == 0)
                image(perfeito, 0, 0, 1019, 573);
              else if(med == 1 || med == -1)
                image(otimo, 0, 0, 1019, 573);
              else if(med == 2 || med == -2)
                image(muitobom, 0, 0, 1019, 573);
              else if( med == 3 || med == -3)
                image(bom, 0, 0, 1019, 573);
              else if(med >= 4 || med <= -4)
                image(ruim, 0, 0, 1019, 573);
                
            }
            if(seg <= -8){
              falarC = false;
              falarF =false;
              geraImagem = false;
              geraImagemFranca = false;
              levelCatalao = 0;
              levelFranca = 0;
              levelCatalaoleft = 0;
              levelFrancaleft = 0;
              levelCatalaoright = 0;
              levelFrancaright = 0;
              videofinal = true;
              mouse ++;
              println("Mouse: "+mouse);
            }
         } 
        
  }
  if(mouse == 4 && videofrancafrase)
  {
        if(audiofrancafrase.isPlaying() && falarF == false){
          image(repetir, 0, 0, 1019, 573);
          //francafrase.play();
          image(francafrase, 165, 30, 690, 410);
        }
        
        for(int i = 0; i < audiofrancafrase.bufferSize() - 1; i++)     //Audio do programa 
        {             
          levelFrancaleft = levelFrancaleft + audiofrancafrase.left.level();
          levelFrancaright = levelFrancaright + audiofrancafrase.right.level();
        }        
        
        levelFranca = levelFrancaleft + levelFrancaright;
        //System.out.println("levelFranca: "+levelFranca);
        if(audiofrancafrase.isPlaying() == false && falarF)
        {
            image(repetir,0,0, 1019, 573);
            int initialTimeF2 = millis();
            int fimF = initialTimeF - initialTimeF2;
            int segF = fimF/1000;
            //println("Fim:  "+segF);
            if(segF >= -3 )
            {
                image(ouvindo, 0,0);
                for(int i = 0; i < in.bufferSize() - 1; i++)  //Entrada de áudio
                {        
                  levelEntradaFrancaright =levelEntradaFrancaright + in.right.level();
                  levelEntradaFrancaleft = levelEntradaFrancaleft + in.left.level();
                }
            }
            levelEntradaFranca = levelEntradaFrancaright + levelEntradaFrancaleft;
            //System.out.println("levelEntradaFranca: "+levelEntradaFranca);
            float diferenca =(levelFranca - levelEntradaFranca)/1000; 
            int dif = int(diferenca);
            
            if(segF<= -4 && segF >= -5)   //Carrega a imagem "carregando" por 2 segundos
            {
              image(carregando, 0,0);
              geraImagemFranca = true;
            }
            else if(segF <= -6 && geraImagemFranca && segF >= -8)  
            {  //Faz as comparações e gera uma imagem de resultado 
             
              if(dif == 0 )
                image(perfeito, 0,0);
              else if(dif == 2 || dif == 3 || dif == -2 || dif == -3 || dif ==1 || dif == -1)
                image(otimo, 0,0);
              else if((dif >= 4 && dif <= 6) || (dif <= -4 && dif >= -6))
                image(muitobom, 0,0);
              else if((dif >=  7 && dif <= 9) || (dif <=  -7 && dif >= -9))
                image(bom, 0,0);
              else if(dif >= 10 || dif <= -10)
                image(ruim, 0,0);
            }
            else if(segF <= -9){
              falarC = false;
              falarF =false;
              geraImagem = false;
              geraImagemFranca = false;
              levelCatalao = 0;
              levelFranca = 0;
              levelCatalaoleft = 0;
              levelFrancaleft = 0;
              levelCatalaoright = 0;
              levelFrancaright = 0;
              videofinal = true;
              mouse ++;
              println("Mouse: "+mouse);
            }
        }
         
    
  }
  else if(mouse == 5 && videofinal && videocatalaoplay)  //Reproduz vídeo final catalão
  {
    image(finalizar, 0, 0);
    //catalaofinal.play();
    //image(catalaofinal, 165, 30, 690, 410);
  }
  else if(mouse == 5 && videofinal && videofrancaplay)     //Reproduz vídeo final francês
  {
    image(finalizar, 0, 0);
    //francafinal.play();
    //image(francafinal, 165, 30, 690, 410);
  }
  
}

void mousePressed()
{
 // println("levelEntradaCatalao: "+levelEntradaCatalao);
 // println("levelCatalao: "+levelCatalao);
  
  catalaofrase.stop();
  francafrase.stop();
  
  switch(mouse)  //utiliza o contador do mouse
  {
    
    case 0: 
      if(mousePressed && mouseX >= 428 && mouseX <= width-430 && mouseY >= 322 && mouseY <= height-91)  
      {
        audiocatalaofrase.rewind();
        audiofrancafrase.rewind();  //Retrocede o áudio para o início para mais adianta ser executado novamente
        videocatalaoplay = false;
        videofrancaplay = false;
        videocatalaofrase = false;
        videofrancafrase =false;
        falarC = false;
        falarF = false;
        image(menu, 0, 0);
        mouse++;
      }
      else
        mouse = 0;
    break;
    
    case 1:
      if(mousePressed && mouseX >= 314 && mouseX <= width-523 && mouseY >= 253 && mouseY <= height-139)  //Entra na opção catalão do menu
      {
        videocatalaoplay = true;
        mouse++;
      }
      else if(mousePressed && mouseX >= 533 && mouseX <= width-305 && mouseY >= 253 && mouseY <= height-139) //Entra na opção França do menu
       {
        videofrancaplay = true;
        mouse++;
      }
      else
        mouse=1;
    break;
    case 2:
      if(mousePressed && mouseX >= 454 && mouseX <= width-454 && mouseY >= 438 && mouseY <= height-22 && videocatalaoplay)
      {
          saudacaocatalao.stop();   
          videofraseC = true;
          mouse++;
      }
      else if(mousePressed && mouseX >= 454 && mouseX <= width-454 && mouseY >= 438 && mouseY <= height-22 && videofrancaplay)
      {
          saudacaofranca.stop();
          videofraseF = true;
          mouse++;
      }
      else
        mouse=2;

    break;
    case 3:
      if(videocatalaoplay){
        audiocatalaofrase.rewind();
        audiocatalaofrase.play();
      }
      else if(videofrancaplay){
        audiofrancafrase.rewind();
        audiofrancafrase.play();
      }
      if(mousePressed && mouseX >= 454 && mouseX <= width-454 && mouseY >= 438 && mouseY <= height-22 && videocatalaoplay)
      {
          catalaofrase.stop();
          francafrase.stop();
          image(repetir, 0, 0, 1019, 573);
          mouse++;
      }
      else if(mousePressed && mouseX >= 454 && mouseX <= width-454 && mouseY >= 438 && mouseY <= height-22 && videofrancaplay)
      {
          catalaofrase.stop();
          francafrase.stop();
          image(repetir, 0, 0, 1019, 573);
          mouse++;          
      }
      else
        mouse=3;
    break;
    case 4:
    
      //catalaofrase.stop();   
      if(mousePressed && mouseX >= 426 && mouseX <= width-419 && mouseY >= 503 && mouseY <= height-18)  //entrada deaudio
      {  
          levelEntradaCatalao = 0;
          levelEntradaFranca = 0;
          levelEntradaCatalaoleft = 0;
          levelEntradaFrancaleft = 0;
          levelEntradaCatalaoright = 0;
          levelEntradaFrancaright = 0;
          
          falarF = true;
          falarC = true;
          initialTime = millis();  //Inicializa contagem de tempo
          initialTimeF = millis();
         // println("initialTimeF: "+initialTimeF);
          mouse =4;
      }
      
      if(mousePressed && mouseX >= 179 && mouseX <= width-664 && mouseY >= 503 && mouseY <= height-18)  //repetir
      {
          catalaofrase.stop();
          francafrase.stop();
          falarC =false;
          falarF =false;
          geraImagem = false;          
          geraImagemFranca = false;          
          image(repetir, 0, 0, 1019, 573);
          if(videocatalaoplay ){
              levelCatalao = 0;   
              levelCatalaoleft = 0; 
              levelCatalaoright = 0; 
              audiocatalaofrase.play(0);  //Executa novamente o áudio             
              mouse =4;
              
          }
          else if(videofrancaplay){
              levelFranca = 0;
              levelFrancaleft = 0;
              levelFrancaright = 0;
              audiofrancafrase.play(0);   //Executa novamente o áudio
              mouse =4;           
          }
          
      }
      if(mousePressed && mouseX >= 657 && mouseX <= width-182 && mouseY >= 503 && mouseY <= height-18)  //Finalizar
      {
        falarC = false;
        falarF =false;
        geraImagem = false;
        geraImagemFranca = false;
        levelCatalao = 0;
        levelFranca = 0;
        levelCatalaoleft = 0;
        levelFrancaleft = 0;
        levelCatalaoright = 0;
        levelFrancaright = 0;
        videofinal = true;
        mouse ++;
      }
        else 
          mouse = 4;
      saudacaocatalao.stop();  //Finaliza o vídeo para poder ser executado novamente 
      saudacaofranca.stop();   //Finaliza o vídeo para poder ser executado novamente 
      
     // System.out.println("levelCatalao: "+levelCatalao);
     // System.out.println("levelEntradaCatalao: "+levelEntradaCatalao);
      
      
    break;
    case 5:
      if(mousePressed && mouseX >= 139 && mouseX <= width-670 && mouseY >= 182 && mouseY <= height-182)  //Tentar novamente  
      {    
          image(repetir, 0, 0,1019, 573);
          if(videocatalaoplay ){
              audiocatalaofrase.play(0);
              mouse =3;
          }
          else if(videofrancaplay){
              audiofrancafrase.play(0);
              mouse =3;
          }
          mouse = 4;
      }
      if(mousePressed && mouseX >= 670 && mouseX <= width-140 && mouseY >= 182 && mouseY <= height-182)  //Finalizar
      {
        videofraseF = false;
        videofraseC = false;
        videocatalaofrase = false;
        videofrancafrase = false;
        image(play, 0, 0);
        mouse = 0;
      }
      if(mousePressed && mouseX >= 404 && mouseX <= width-408 && mouseY >= 182 && mouseY <= height-182)  // Escolhaoutro Idioma
      {
        image(menu,0,0);
        videocatalaofrase = false;
        videofrancafrase = false;
        videocatalaoplay = false;
        videofrancaplay = false;
        videofraseF = false;
        videofraseC = false;
        mouse = 1;
      }
      //catalaofinal.stop();  //Finaliza o vídeo final para que possa ser reproduzido novamente mais adiante
    break;
  }
  //println("Mouse: " +mouse);  //print para acompanhar a contagem do mouse
}

void movieEvent(Movie m) {
  m.read();
}

void entradadeaudiocatalao()  // função para executar o áudio catalão
{
        
        videocatalaofrase = true;
        audiocatalaofrase.play();
        
        //audiocatalaofrase.cue(0);
        
}
void entradadeaudiofranca()    // função para executar o áudio francês  
{
        videofrancafrase = true;
        
        
        audiofrancafrase.play();
        //audiocatalaofrase.mute();
}