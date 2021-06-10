{
  var towerImg, tower;
  var doorImg, door, doorsGroup;
  var climberImg, climber, climbersGroup;
  var ghost, ghostImg;
  var invisibleBlockGroup, invisibleBlock;
  var gameState = "play"
}

function preload()

{
  towerImg = loadImage("tower.png");
  doorImg = loadImage("door.png");
  climberImg = loadImage("climber.png");
  ghostImg = loadImage("ghost-standing.png");
  spookySound = loadSound("spooky.wav");

}

function setup() {
  createCanvas(600, 600)

  tower = createSprite(300, 300, 10, 10);
  tower.addImage(towerImg);
  tower.velocityY = 1;

spookySound.loop()

  ghost = createSprite(200, 200, 10, 10);
  ghost.addImage(ghostImg);
  ghost.scale = 0.5;



  climbersGroup = new Group();
  doorsGroup = new Group();
  invisibleBlockGroup = new Group();




}

function draw() {
  background(0)
  if (gameState === "play") {


    if (tower.y > 400) {
      tower.y = 300;
    }

    if (keyDown("space")) {
      ghost.velocityY = -10;
    }
    ghost.velocityY = ghost.velocityY + 0.8;


    if (keyDown("right_arrow")) {
      ghost.x = ghost.x + 3;
    }
    if (keyDown("left_arrow")) {
      ghost.x = ghost.x - 3;
    }

    if (climbersGroup.isTouching(ghost)) {
      ghost.velocityY = 0;
    }
    if (invisibleBlockGroup.isTouching(ghost) ||
      ghost.y > 600) {
      ghost.destroy()
      gameState = "END";
    }



    spawnDoors()


    drawSprites()
  }
  if (gameState === "END") {
    stroke("yellow");
    fill("yellow");
    textSize(30);
    text("Game Over", 230, 250)
    
  }

}


function spawnDoors() {
  if (frameCount % 240 === 0) {
    var door = createSprite(200, -50);
    var climber = createSprite(200, 10);
    var invisibleBlock = createSprite(200, 15);
    invisibleBlock.width = climber.width;
    invisibleBlock.height = 2;

    door.x = Math.round(random(120, 400));
    climber.x = door.x;
    invisibleBlock.x = door.x;

    door.addImage(doorImg);
    climber.addImage(climberImg);
    door.velocityY = 1;
    climber.velocityY = 1;
    invisibleBlock.velocityY = 1;
    ghost.depth = door.depth;
    ghost.depth += 1;
    door.lifetime = 800;
    climber.lifetime = 800;
    invisibleBlock.lifetime = 800;
    doorsGroup.add(door);
    invisibleBlock.debug = false;
    climbersGroup.add(climber);
    invisibleBlockGroup.add(invisibleBlock);

  }
}
