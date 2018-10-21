///particle_add(type, life, color, alpha, x, y, vx, vy, wid, hei, rot)
with (oPART)
{
    var type = argument0;
    var life = argument1;
    var col = argument2;
    var alpha = argument3;
    var _x = argument4;
    var _y = argument5;
    var vx = argument6;
    var vy = argument7;
    var wid = argument8;
    var hei = argument9;
    var rot = argument10;
    
    // Find a free place for particle
    var found = false, i;
    // Last part
    for (i=particleIdx; i<PT_MAX_SIZE; i++)
    {
        if (particles[# ePART.TYPE, i] == ePTYPE.UNUSED)
        {
            particleIdx = i;
            found = true;
        }
    }
    
    // First part
    if (!found)
    {
        for (i=0; i<particleIdx; i++)
        {
            if (particles[# ePART.TYPE, i] == ePTYPE.UNUSED)
            {
                particleIdx = i;
                found = true;
            }
        }
    }
    
    if (!found)
        particleIdx = 0;
    
    particles[# ePART.LIFE, particleIdx] = life;
    particles[# ePART.TYPE, particleIdx] = type;
    particles[# ePART.COL, particleIdx] = col;
    particles[# ePART.ALPHA, particleIdx] = alpha;
    particles[# ePART.X, particleIdx] = _x;
    particles[# ePART.Y, particleIdx] = _y;
    particles[# ePART.VX, particleIdx] = vx;
    particles[# ePART.VY, particleIdx] = vy;
    particles[# ePART.WID, particleIdx] = wid;
    particles[# ePART.HEI, particleIdx] = hei;
    particles[# ePART.ROT, particleIdx] = rot;
}
