function [A] = myLinearContrastStretching(B)
    if max(B,[],'all')>256
        "Warning: Maximum intensity is >256, this will decrease the contrast"
    end
    A=(256/max(B,[],'all'))*B;
   
end