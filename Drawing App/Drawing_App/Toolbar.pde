final int ICON_SIZE = 40;

class Toolbar
{
  public final int HEIGHT = 64;
  public final int X_OFFSET = 14;
  public final int Y_OFFSET = 14;
  
  public color selectedColor;

  public PGraphics pg;
  public ArrayList<Tool> tools;

  //private int iconOffset = 14;


  private Toolbar()
  {
    tools = new ArrayList<Tool>();
    
    selectedColor = color(0);
  }

  public void AddTool(Tool _tool)
  {
    tools.add(_tool);
    _tool.x = (ICON_SIZE * (tools.size() - 1)) + X_OFFSET;
    _tool.y = Y_OFFSET;
  }

  public void AddTool(Tool _tool, int _x, int _y)
  {
    tools.add(_tool);
    _tool.x = _x;
    _tool.y = _y;
  }

  public void HighlightTool()
  {
    fill(127, 127, 255, 50);

    Tool tool = GetMouseOverTool();

    rect(tool.x, tool.y, ICON_SIZE, ICON_SIZE);
  }
  
  public void HighlightTool(Tool _tool)
  {
    fill(127, 255, 127, 50);
    
    rect(_tool.x, _tool.y, ICON_SIZE, ICON_SIZE);
  }

  public void Display()
  {
    image(pg, 0, 0);

    for (int i = 0; i < tools.size(); i++)
    {
      Tool tool = tools.get(i);

      PShape shape = tool.icon;

      shape(shape, tool.x, tool.y, ICON_SIZE, ICON_SIZE);
    }
    
    //print("Active Tool: " + activeTool.name + "\n");
    fill(selectedColor);
    rect(appWidth - 3 * ICON_SIZE, Y_OFFSET, ICON_SIZE, ICON_SIZE);
  }

  public Tool GetMouseOverTool()
  {
    for (int i = 0; i < tools.size(); i++)
    {
      Tool tool = tools.get(i);

      if (mouseX > tool.x && mouseX < tool.x + ICON_SIZE && mouseY < HEIGHT)
        return tool;
    }

    return null;
  }

  public boolean OverToolbar()
  {
    return (mouseY <= HEIGHT);
  }
  
  public boolean OverTool()
  {
    for (int i = 0; i < tools.size(); i++)
    {
      Tool tool = tools.get(i);

      if (mouseX > tool.x && mouseX < tool.x + ICON_SIZE && mouseY < HEIGHT)
        return true;
    }
    
    return false;
  }
}
