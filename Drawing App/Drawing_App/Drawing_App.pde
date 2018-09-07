final int appWidth = 1280;
final int appHeight = 720;

Toolbar toolbar;
Tool activeTool;

HScrollbar hs;

Wheel wheelTool;


PGraphics pgDrawing;

void setup() 
{
  // Canvas:
  size(1280, 720);

  // Toolbar:
  toolbar = new Toolbar();

  toolbar.pg = createGraphics(appWidth, toolbar.HEIGHT);
  toolbar.pg.beginDraw();
  toolbar.pg.background(230);
  toolbar.pg.endDraw();

  // Tools:
  Pencil pencilTool = new Pencil(loadShape("pencil.svg"));
  Brush brushTool = new Brush(loadShape("brush.svg"));
  Eraser eraserTool = new Eraser(loadShape("eraser.svg"));
  wheelTool = new Wheel(loadShape("wheel.svg"));


  activeTool = brushTool;
  activeTool.selecting = true;

  toolbar.AddTool(pencilTool);
  toolbar.AddTool(eraserTool);
  toolbar.AddTool(brushTool);
  toolbar.AddTool(wheelTool, appWidth - ICON_SIZE - toolbar.X_OFFSET, toolbar.Y_OFFSET);

  // Scrollbar:
  hs = new HScrollbar(ICON_SIZE * 3 + 20, toolbar.HEIGHT / 3, 116, 16, 16);

  // Drawing Area:
  pgDrawing = createGraphics(appWidth, appHeight - toolbar.HEIGHT);
} 

void draw()
{
  background(255);

  HandleDrawing();

  toolbar.Display();

  HandleToggles();

  HandleCursor();

  LateUpdate();
}

void HandleToggles()
{
  if (wheelTool.selecting)
  {
    wheelTool.cp.render();
  }

  hs.update();
  int sliderVal = (int)hs.spos - 139;
  

  if (activeTool instanceof Brush || activeTool instanceof Eraser || activeTool instanceof Wheel)
  {
    hs.display();
    activeTool.strokeWeight = sliderVal;
  }
}

void LateUpdate()
{
  // Highlight moused over tool:
  Tool tool = toolbar.GetMouseOverTool();

  if (tool != null)
  {
    toolbar.HighlightTool();
  }

  // Highlight selected tool:
  if (activeTool instanceof Wheel) {
    ;
  } else
    toolbar.HighlightTool(activeTool);
}

void mouseReleased()
{
  Tool tool = toolbar.GetMouseOverTool();

  if (tool != null)
  {
    tool.Select();
  }
}


// Key Inputs:
void keyPressed()
{
  // Brush Size:

  // Toolbar Shortcuts:
  int numPressed = int(key) - 49;

  if (numPressed >= 0 && numPressed < toolbar.tools.size())
  {
    Tool tool = toolbar.tools.get(numPressed);

    if (tool != null)
      tool.Select();
  }
}

void HandleCursor()
{
  boolean overToolbar = toolbar.OverToolbar();
  boolean overTool = toolbar.OverTool();

  if (overToolbar)
  {
    if (overTool)
      cursor(HAND);
    else
      cursor(ARROW);
  } else
  {
    if (wheelTool.OverWheel())
      cursor(CROSS);
    else
    {
      noCursor();
      fill(0, 0, 0, 0);
      stroke(0);
      ellipse(mouseX, mouseY, activeTool.strokeWeight, activeTool.strokeWeight);
    }
  }
}


//
// Handles increase and decrease of brush size
//




//
// Handles drawing with the mouse button held down
//
void HandleDrawing()
{
  if (mousePressed && !wheelTool.OverWheel() && !hs.overEvent()) 
  {
    pgDrawing.beginDraw();

    pgDrawing.stroke(activeTool.stroke);
    pgDrawing.fill(activeTool.fill);
    pgDrawing.strokeWeight(activeTool.strokeWeight);

    pgDrawing.line(pmouseX, pmouseY, mouseX, mouseY);

    pgDrawing.endDraw();
  }

  image(pgDrawing, 0, 0);
}
