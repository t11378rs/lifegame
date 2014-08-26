final int SIZE_OF_CELL = 10;
final int FRAME_SIZE_OF_X = 800;
final int FRAME_SIZE_OF_Y = 800;
int num_of_row = FRAME_SIZE_OF_Y / SIZE_OF_CELL; //gyou  
int num_of_col = FRAME_SIZE_OF_X / SIZE_OF_CELL; //retsu
int num_of_cell = num_of_row * num_of_col;
Cell[][] cells = new Cell[num_of_row][num_of_col];
boolean game_state = false;

class Point{
  int row, col;
  Point(int my_row, int my_col){
    row = my_row;
    col = my_col;
  }
  int getRow(){
    return row;
  }
  int getCol(){
    return col;
  }
}

class Cell{
  int x, y;
  boolean state;

  Cell(int my_x, int my_y, boolean s){
    x = my_x;
    y = my_y;
    state = s;
  }
  
  void changeState(){
    state = !state;
  }
  
  void appear(){
    if(state){
      fill(255, 255, 255);
      //fill(50, 50, 50);
    }else{
      fill(50, 50, 50);
      //fill(255, 255, 255);
    }
    rect(x, y, SIZE_OF_CELL, SIZE_OF_CELL);
  }
}

void check_life_and_death(){
  ArrayList<Point> points = new ArrayList<Point>();
  for(int row=0; row<num_of_row; row++){
    for(int col=0; col<num_of_col; col++){
      //jibun no mawari check
      int num_of_alivers = 0;
      for(int r=-1; r<=1; r++){
        for(int c=-1; c<=1; c++){
          if(row+r<0 || row+r>=num_of_row || col+c<0 || col+c>=num_of_col){
            continue;
          } 
          if(cells[row+r][col+c].state){
            num_of_alivers++;
          }
        }
      }
      if(cells[row][col].state){ //jibun no bun wo hiku
        num_of_alivers--;
      }
      //joutai change no note
      if(cells[row][col].state){
        if(num_of_alivers<=1  || num_of_alivers>=4){
          points.add(new Point(row, col));
        }
      }else{
        if(num_of_alivers==3){
          points.add(new Point(row, col));
        }
      }
    }
  } 
  for(int i=0; i<points.size(); i++){
    Point point = points.get(i);
    int point_row = point.getRow();
    int point_col = point.getCol();
    cells[point_row][point_col].changeState();
  }
}

//random setup
void randomSetup(){
  size(FRAME_SIZE_OF_X, FRAME_SIZE_OF_Y);
  frameRate(20);
  for(int row=0; row<num_of_row; row++){
    for(int col=0; col<num_of_col; col++){
      int position_x = col * SIZE_OF_CELL;
      int position_y = row * SIZE_OF_CELL;
      float coin_seed = random(1);
      boolean coin;
      if(coin_seed>0.8){
        coin = true;
      }else{
        coin = false;
      }
      cells[row][col] = new Cell(position_x, position_y, coin);
    }
  }  
}

void keyPressed(){
  print("Key");
  game_state = !game_state;
  if(key=='r' || key=='R'){
    randomSetup();
  }else if(key=='c' || key=='C'){
    setup();
  }
}

void mouseClicked(){
  int cell_col = mouseX/SIZE_OF_CELL;
  int cell_row = mouseY/SIZE_OF_CELL;
  cells[cell_row][cell_col].changeState();
  print("Clicked");
  print(cell_col);
  print(cell_row);
}

void setup(){
  size(FRAME_SIZE_OF_X, FRAME_SIZE_OF_Y);
  frameRate(20);
  for(int row=0; row<num_of_row; row++){
    for(int col=0; col<num_of_col; col++){
      int position_x = col * SIZE_OF_CELL;
      int position_y = row * SIZE_OF_CELL;
      cells[row][col] = new Cell(position_x, position_y, false);
    }
  }  
}
void draw() {
  if(!game_state){
  }else{
    check_life_and_death();
  }
  for(int row=0; row<num_of_row; row++){
    for(int col=0; col<num_of_col; col++){
      cells[row][col].appear();
    }
  }
  //sdelay(500);
}
