XTLKPST ;SFISC/JC;FIX DD OF 8984.1, 8984.2 ;02/10/95  12:17
 ;;7.3;TOOLKIT;;Apr 25, 1995
 ;Removes garbage variable pointer nodes from DD if files 52, 80, and 80.1 aren't configured for MTLU.
 W !,"One moment while I check/clean up MTLU variable pointers."
 N ZX,L
 F ZX=52,80,80.1 D
 .Q:$D(^XT(8984.4,ZX))
 .F L=8984.1,8984.2 S DIK="^DD("_L_",.02,""V"",",DA(1)=.02,DA(2)=L,DA=$O(^DD(L,.02,"V","B",ZX,0)) D:DA'="" ^DIK
 W !,"Done..."
