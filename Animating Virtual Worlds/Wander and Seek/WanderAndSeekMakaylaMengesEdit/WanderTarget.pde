class WanderTarget
{
  WanderTarget(PVector target)
  {
    
  }
  PVector target(PVector target)
  {
    PVector target1 = target;
    fill(10, 220, 40);
    stroke(0);
    ellipse( target.x, target.y, 15, 15 );
    
    return target1;
  }
}