abstract class Tool
{
  public String name;
  public PShape icon;
  public int x, y;
  
  public boolean selecting;
  
  public int strokeWeight;
  public color stroke;
  public color fill;
  
  public ColorPicker cp;

  Tool(PShape _icon)
  {
    icon = _icon;
    
    strokeWeight = 5;
    stroke = color(0);
    fill = color(0);
    
    selecting = false;    
  }

  public void Select()
  {
    print("Interacting\n");
  }
}

class Pencil extends Tool
{
  Pencil(PShape _icon)
  {
    super(_icon);
    name = "Pencil";
  }
  
  public void Select()
  {
    activeTool = this;
    
    strokeWeight = 1;
  }
}

class Brush extends Tool
{
  Brush(PShape _icon)
  {
    super(_icon);
    name = "Brush";
  }
  
  public void Select()
  {
    activeTool = this;
  }
}

class Eraser extends Tool
{
  Eraser(PShape _icon)
  {
    super(_icon);
  }
  
  public void Select()
  {
    activeTool = this;
    name = "Eraser";
    
    strokeWeight = 10;
    stroke = color(255);
    print("Eraser: " + selecting + "\n");
  }
}

class Wheel extends Tool
{
  public ColorPicker cp;
  
  Wheel(PShape _icon)
  {
    super(_icon);
    name = "Color Wheel";
    
    cp = new ColorPicker(appWidth - 410, toolbar.HEIGHT, 400, 400, 0);
  }
  
  public void Select()
  {
    activeTool = this;
    selecting = !selecting;
  }
  
  public boolean OverWheel()
  {
    if (selecting)
      return (mouseX > appWidth - 420 && mouseX < appWidth && mouseY > toolbar.HEIGHT && mouseY < 506);
    else
      return false;
  }
}
