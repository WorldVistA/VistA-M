ECDSONL ;BIR/RHK - Event Capture Online Documentation ;25 Apr 95
 ;;2.0; EVENT CAPTURE ;;8 May 96
 N DIR,DIRUT,XQH,XQHFY,X,Y
 S DIR(0)="SO^1:Interactive Help;2:Documentation"
 D ^DIR G:'Y QUIT
 S XQH="ECDSONLINE" I Y=1 D EN^XQH G QUIT
 S XQHFY=XQH D ACTION^XQH4
QUIT ;
 K DIR
 Q
