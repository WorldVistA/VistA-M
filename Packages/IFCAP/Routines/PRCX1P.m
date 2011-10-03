PRCX1P ;WISC/PLT-IFCAP ROTUINE TO FIX COPY REQUESTS & P.O ; 10/17/95  3:26 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;QUIT  ; invalid entry
 ;
EN ;start FIXing
 N PRCIVER,PRCRI,PRCFIXV,PRCOPT,PRC5INST,PRCQ21,PRCDUZ
Q1 D EN^DDIOL(" "),EN^DDIOL("The option will fix the copied requests with wrong BBFY, APPROPRIATION")
 D EN^DDIOL("    and FCP/PRC(ACC).")
 ;D EN^DDIOL("The option 2 will rebuild the rejected MO/SO FMS-documents with wrong")
 ;D EN^DDIOL("    BBFY and APPROPRIATION in purchase orders.")
 ;D SC^PRC0A(.X,.Y,"Select IFCAP V5 FIX option","OM^1:(2237,1358) Requests(1996-) BBFY, APPROPRIATION and FCP/PRJ(ACC) EDIT;2:Purchase Orders(1996-) BBFY and APPROPRIATION rebuild","")
 ;G:X["^"!(X="") EXIT
 S PRCOPT=1
 ;
Q2 ;select auto/single
 G:PRCOPT=2 Q3
 D SC^PRC0A(.X,.Y,"Select "_$P("(2237,1358) REQUESTS","^",PRCOPT)_" Edit Option","OM^1:AUTO EDIT TRANSACTIONS in file 410;2:MANUAL SELECT TRANSACTION in file 410","")
 G:X["^"!(X="") EXIT
 S $P(PRCOPT,"^",2)=X
Q3 D YN^PRC0A(.X,.Y,"Ready to run the selected option ","O","NO")
 G:X["^"!(X="")!(Y<1) Q1
 I +PRCOPT<2 D  D EN^PRCX1P1:$P(PRCOPT,"^",2)=1,EN1^PRCX1P1:$P(PRCOPT,"^",2)=2 G Q1
 . S PRCDD=410
 . QUIT
 D:PRCOPT=2 GECS^PRCX1P1
EXIT ;
 QUIT
 ;
