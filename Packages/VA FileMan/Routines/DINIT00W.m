DINIT00W ; SFISC/TKW-DIALOG & LANGUAGE FILE INITS ;05:40 PM  21 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) S @X=Y
Q Q
 ;;^UTILITY(U,$J,.84,9254,2,1,0)
 ;;=                                                          \BHelp Screen 4 of 9\n
 ;;^UTILITY(U,$J,.84,9254,2,2,0)
 ;;=\BEDITING A CAPTION OR DATA LENGTH\n
 ;;^UTILITY(U,$J,.84,9254,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9254,2,4,0)
 ;;=To edit the caption or data length of an element from the Form Editor's
 ;;^UTILITY(U,$J,.84,9254,2,5,0)
 ;;=Main screen, you can position the cursor over the caption or data portion
 ;;^UTILITY(U,$J,.84,9254,2,6,0)
 ;;=of the element and press:
 ;;^UTILITY(U,$J,.84,9254,2,7,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9254,2,8,0)
 ;;=     <F3>     Edit caption or data length
 ;;^UTILITY(U,$J,.84,9254,2,9,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9254,2,10,0)
 ;;=If you press <F3> while the cursor is over a caption, you'll be taken
 ;;^UTILITY(U,$J,.84,9254,2,11,0)
 ;;=into a caption editor.  The editing keys available to you are identical
 ;;^UTILITY(U,$J,.84,9254,2,12,0)
 ;;=to those in ScreenMan's field editor.
 ;;^UTILITY(U,$J,.84,9254,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9254,2,14,0)
 ;;=If you press <F3> while the cursor is over the data portion of an element,
 ;;^UTILITY(U,$J,.84,9254,2,15,0)
 ;;=you can then use the <Right> and <Left> arrow keys to increase and
 ;;^UTILITY(U,$J,.84,9254,2,16,0)
 ;;=decrease the data length.  An indicator at the lower right edge of the
 ;;^UTILITY(U,$J,.84,9254,2,17,0)
 ;;=screen indicates the current length of the data.  Press <Enter> to exit
 ;;^UTILITY(U,$J,.84,9254,2,18,0)
 ;;=the caption or data length editor.
 ;;^UTILITY(U,$J,.84,9255,0)
 ;;=9255^3^^5
 ;;^UTILITY(U,$J,.84,9255,1,0)
 ;;=^^1^1^2940707^
 ;;^UTILITY(U,$J,.84,9255,1,1,0)
 ;;=Help Screen 5 of Form Editor.
 ;;^UTILITY(U,$J,.84,9255,2,0)
 ;;=^^18^18^2940707^
 ;;^UTILITY(U,$J,.84,9255,2,1,0)
 ;;=                                                          \BHelp Screen 5 of 9\n
 ;;^UTILITY(U,$J,.84,9255,2,2,0)
 ;;=\BVIEWING THE BLOCKS ON A PAGE\n
 ;;^UTILITY(U,$J,.84,9255,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9255,2,4,0)
 ;;=The Form Editor's main screen displays the field elements on a page, but
 ;;^UTILITY(U,$J,.84,9255,2,5,0)
 ;;=does not display any information about the blocks on that page.  A Block
 ;;^UTILITY(U,$J,.84,9255,2,6,0)
 ;;=Viewer screen shows the blocks on a page.  From the Block Viewer screen
 ;;^UTILITY(U,$J,.84,9255,2,7,0)
 ;;=you can move entire blocks, and edit block properties.
 ;;^UTILITY(U,$J,.84,9255,2,8,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9255,2,9,0)
 ;;=Press    To
 ;;^UTILITY(U,$J,.84,9255,2,10,0)
 ;;=-----------------------------------------------------------
 ;;^UTILITY(U,$J,.84,9255,2,11,0)
 ;;=<F1>V   Toggle between Block Viewer screen and Main screen
 ;;^UTILITY(U,$J,.84,9255,2,12,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9255,2,13,0)
 ;;=The Block Viewer screen displays the names of the blocks on the current
 ;;^UTILITY(U,$J,.84,9255,2,14,0)
 ;;=page.  From this screen, you can select blocks and edit their properties.
 ;;^UTILITY(U,$J,.84,9255,2,15,0)
 ;;=To return to the Form Editor's main screen, press <F1>V, <F1>E, or <F1>Q.
 ;;^UTILITY(U,$J,.84,9255,2,16,0)
 ;;=If two blocks have the some coordinates, the block names will overlap on
 ;;^UTILITY(U,$J,.84,9255,2,17,0)
 ;;=the Block Viewer screen.  Also, since header blocks have a fixed position
 ;;^UTILITY(U,$J,.84,9255,2,18,0)
 ;;=of (1,1) relative to the page, they cannot be moved.
 ;;^UTILITY(U,$J,.84,9256,0)
 ;;=9256^3^^5
 ;;^UTILITY(U,$J,.84,9256,1,0)
 ;;=^^1^1^2940707^
 ;;^UTILITY(U,$J,.84,9256,1,1,0)
 ;;=Help Screen 6 of Form Editor.
 ;;^UTILITY(U,$J,.84,9256,2,0)
 ;;=^^10^10^2940707^
 ;;^UTILITY(U,$J,.84,9256,2,1,0)
 ;;=                                                          \BHelp Screen 6 of 9\n
 ;;^UTILITY(U,$J,.84,9256,2,2,0)
 ;;=\BPAGE NAVIGATION\n
 ;;^UTILITY(U,$J,.84,9256,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9256,2,4,0)
 ;;=Press             To move to
 ;;^UTILITY(U,$J,.84,9256,2,5,0)
 ;;=----------------------------------------------------------
 ;;^UTILITY(U,$J,.84,9256,2,6,0)
 ;;=<F1><F1><Up>    Previous page
 ;;^UTILITY(U,$J,.84,9256,2,7,0)
 ;;=<F1><F1><Down>  Next page
 ;;^UTILITY(U,$J,.84,9256,2,8,0)
 ;;=<SelectElement>D  Subpage associated with selected element
 ;;^UTILITY(U,$J,.84,9256,2,9,0)
 ;;=<F1>C            Parent page (Close current pop-up page)
 ;;^UTILITY(U,$J,.84,9256,2,10,0)
 ;;=<F1>P            A specific page (you are prompted for the page)
 ;;^UTILITY(U,$J,.84,9257,0)
 ;;=9257^3^^5
 ;;^UTILITY(U,$J,.84,9257,1,0)
 ;;=^^1^1^2940725^^
 ;;^UTILITY(U,$J,.84,9257,1,1,0)
 ;;=Help Screen 7 of Form Editor.
 ;;^UTILITY(U,$J,.84,9257,2,0)
 ;;=^^15^15^2940725^
 ;;^UTILITY(U,$J,.84,9257,2,1,0)
 ;;=                                                          \BHelp Screen 7 of 9\n
 ;;^UTILITY(U,$J,.84,9257,2,2,0)
 ;;=\BSELECTING, ADDING, AND EDITING FORM ELEMENTS\n
 ;;^UTILITY(U,$J,.84,9257,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9257,2,4,0)
 ;;=Press   To
 ;;^UTILITY(U,$J,.84,9257,2,5,0)
 ;;=----------------------------------------
 ;;^UTILITY(U,$J,.84,9257,2,6,0)
 ;;=<F1>M  Select another form
 ;;^UTILITY(U,$J,.84,9257,2,7,0)
 ;;=<F1>P  Select another page
 ;;^UTILITY(U,$J,.84,9257,2,8,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9257,2,9,0)
 ;;=<F2>M  Add a new form
 ;;^UTILITY(U,$J,.84,9257,2,10,0)
 ;;=<F2>P  Add a new page
 ;;^UTILITY(U,$J,.84,9257,2,11,0)
 ;;=<F2>B  Add a new block
 ;;^UTILITY(U,$J,.84,9257,2,12,0)
 ;;=<F2>F  Add a new field element
 ;;^UTILITY(U,$J,.84,9257,2,13,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9257,2,14,0)
 ;;=<F4>M  Edit properties of current form
 ;;^UTILITY(U,$J,.84,9257,2,15,0)
 ;;=<F4>P  Edit properties of current page
 ;;^UTILITY(U,$J,.84,9258,0)
 ;;=9258^3^^5
 ;;^UTILITY(U,$J,.84,9258,1,0)
 ;;=^^1^1^2940707^
 ;;^UTILITY(U,$J,.84,9258,1,1,0)
 ;;=Help Screen 8 of Form Editor.
 ;;^UTILITY(U,$J,.84,9258,2,0)
 ;;=^^11^11^2940707^
 ;;^UTILITY(U,$J,.84,9258,2,1,0)
 ;;=                                                          \BHelp Screen 8 of 9\n
 ;;^UTILITY(U,$J,.84,9258,2,2,0)
 ;;=\BDELETING ELEMENTS\n
 ;;^UTILITY(U,$J,.84,9258,2,3,0)
 ;;= 
 ;;^UTILITY(U,$J,.84,9258,2,4,0)
 ;;=To delete an element, edit the properties of the element, and enter an
 ;;^UTILITY(U,$J,.84,9258,2,5,0)
 ;;=at-sign (@) at the first field of the ScreenMan form.  For example, to
 ;;^UTILITY(U,$J,.84,9258,2,6,0)
 ;;=delete a field from a block, select the field with <SpaceBar>, press <F4>
 ;;^UTILITY(U,$J,.84,9258,2,7,0)
 ;;=to invoke the "edit properties" form, and enter @ at the "Field Order:"
