XVEMGUM ;DJB/VGL**Scroll Messages [2/24/99 10:39am];2017-08-15  12:49 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
MSG(NUM,PAUSE) ;Messages
 ;NUM=Subroutine number  PAUSE=Pause screen
 Q:$G(NUM)'>0
 S DX=0,DY=XVVT("S2")+XVVT("FT")-2
 D CURSOR^XVEMKU1(DX,DY,1),@NUM
 S DX=0,DY=DY+1 I $G(PAUSE) X XVVS("CRSR") D PAUSE^XVEMKU(0)
 Q
 ;====================================================================
1 W $C(7),"Enter number from left hand column." Q
2 W $C(7),"This node is not viewable." Q
3 W $C(7),"Node not viewable. Isn't in standard Fileman format." Q
4 W $C(7),"You don't have access. See Help option." Q
5 W $C(7),"You can't use this option while reverse video is active." Q
6 W $C(7),"No editing while ",$S($G(FLAGVPE)["VEDD":"VEDD",1:"VRR")," is running" Q
7 W $C(7),"You can't edit in an alternate session." Q
8 W $C(7),"You're already doing a code search!?" Q
9 W $C(7),"There is no data to be searched" Q
10 W $C(7),"Only 1 Alternate Session allowed." Q
11 W $C(7),"No Alternate Session allowed when ",$S($G(FLAGVPE)["VEDD":"VEDD",1:"VRR")," is running" Q
12 W $C(7),"Invalid. This node already exists." Q
13 W $C(7),"Subscript is greater than 127 characters" Q
14 W $C(7),"You may not edit a null node" Q
15 W $C(7),"Invalid selection ('%' Node)." Q
16 W $C(7),"Invalid selection (File of files not viewable)." Q
17 W $C(7),"This is not a valid node." Q
18 W $C(7),"VA Filemanager must be present to run this option." Q
19 W "Enter number from left hand column, or a range of numbers (Ex: 3-5)" Q
20 W $C(7),"Invalid range" Q
21 W "Enter new node to hold SAved code. Hit <TAB> to quit." Q
22 W $C(7),"No code has been saved." Q
23 W $C(7),"You may NOT edit the subscript of a node that has decendents" Q
24 W "After editing a range of nodes, exit and reenter VGL to see your changes." Q
25 W "No control characters found." Q
26 W "This node has control characters. Use SC to strip them out before editing." Q
