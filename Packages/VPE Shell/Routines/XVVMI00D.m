XVVMI00D ; ; 04-JAN-2004
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 Q:'DIFQR(19200.114)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,19200.114,37,"WP1",29,0)
 ;;=    If erroneous input is entered, 2 question marks will be displayed and
 ;;^UTILITY(U,$J,19200.114,37,"WP1",30,0)
 ;;=    a beep will sound.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",31,0)
 ;;=S = Suppress display of .01 (except B xref match)
 ;;^UTILITY(U,$J,19200.114,37,"WP1",32,0)
 ;;=    If DIC(0) does not contain S, the value of the .01 field will be
 ;;^UTILITY(U,$J,19200.114,37,"WP1",33,0)
 ;;=    displayed for all matches found in any xref. If it does contain S, the
 ;;^UTILITY(U,$J,19200.114,37,"WP1",34,0)
 ;;=    .01 field won't be displayed unless the match was found in the B xref.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",35,0)
 ;;=X = Exact match required
 ;;^UTILITY(U,$J,19200.114,37,"WP1",36,0)
 ;;=    The input value must be found exactly as it was entered. Otherwise,
 ;;^UTILITY(U,$J,19200.114,37,"WP1",37,0)
 ;;=    the routine will look for any entries that begin with the input X.
 ;;^UTILITY(U,$J,19200.114,37,"WP1",38,0)
 ;;=Z = Zero node returned in Y(0) and external form in Y(0,0)
 ;;^UTILITY(U,$J,19200.114,37,"WP1",39,0)
 ;;=    If lookup was successful, then variable Y(0) will be returned equal to
 ;;^UTILITY(U,$J,19200.114,37,"WP1",40,0)
 ;;=    the entire zero node of the entry. Y(0,0) is also returned and will be
 ;;^UTILITY(U,$J,19200.114,37,"WP1",41,0)
 ;;=    equal to the printable expression of the .01 field. This means that
 ;;^UTILITY(U,$J,19200.114,37,"WP1",42,0)
 ;;=    for Date/Time, Set of Codes, and Pointer data types, Y(0,0) will
 ;;^UTILITY(U,$J,19200.114,37,"WP1",43,0)
 ;;=    contain the external format.
 ;;^UTILITY(U,$J,19200.114,38,0)
 ;;=DIC('A')
 ;;^UTILITY(U,$J,19200.114,38,"WP",0)
 ;;=^^1^1^2960113^
 ;;^UTILITY(U,$J,19200.114,38,"WP",1,0)
 ;;=Default prompt.
 ;;^UTILITY(U,$J,19200.114,39,0)
 ;;=DIC('B')
 ;;^UTILITY(U,$J,19200.114,39,"WP",0)
 ;;=^^1^1^2960113^
 ;;^UTILITY(U,$J,19200.114,39,"WP",1,0)
 ;;=Default answer.
 ;;^UTILITY(U,$J,19200.114,40,0)
 ;;=DIC('S')
 ;;^UTILITY(U,$J,19200.114,40,"WP",0)
 ;;=^^4^4^2960113^
 ;;^UTILITY(U,$J,19200.114,40,"WP",1,0)
 ;;=String of MUMPS code that DIC will use to screen an entry from
 ;;^UTILITY(U,$J,19200.114,40,"WP",2,0)
 ;;=selection. If $T=1 entry will be displayed. When DIC("S") is
 ;;^UTILITY(U,$J,19200.114,40,"WP",3,0)
 ;;=executed, Y=IEN and naked indicator is at the global level
 ;;^UTILITY(U,$J,19200.114,40,"WP",4,0)
 ;;=@(DIC_"Y,0)").
 ;;^UTILITY(U,$J,19200.114,41,0)
 ;;=DIC('W')
 ;;^UTILITY(U,$J,19200.114,41,"WP",0)
 ;;=^^4^4^2960113^
 ;;^UTILITY(U,$J,19200.114,41,"WP",1,0)
 ;;=A MUMPS string that will be executed when DIC displays each entry
 ;;^UTILITY(U,$J,19200.114,41,"WP",2,0)
 ;;=that matches user input. Y and naked indicator are the same as for
 ;;^UTILITY(U,$J,19200.114,41,"WP",3,0)
 ;;=DIC("S"). DIC("W") overrides identifiers. So, DIC("W")="" will
 ;;^UTILITY(U,$J,19200.114,41,"WP",4,0)
 ;;=suppress the display of identifiers.
 ;;^UTILITY(U,$J,19200.114,42,0)
 ;;=DIC('DR')
 ;;^UTILITY(U,$J,19200.114,42,"WP",0)
 ;;=^^3^3^2960114^^
 ;;^UTILITY(U,$J,19200.114,42,"WP",1,0)
 ;;=When DIC(0) contains L, you can specify fields to be asked for if
 ;;^UTILITY(U,$J,19200.114,42,"WP",2,0)
 ;;=user enters new entry. Looks same as DIE's DR string. This overrides
 ;;^UTILITY(U,$J,19200.114,42,"WP",3,0)
 ;;=the asking of identifiers.
 ;;^UTILITY(U,$J,19200.114,43,0)
 ;;=DIC('P')
 ;;^UTILITY(U,$J,19200.114,43,"WP",0)
 ;;=^^4^4^2960115^
 ;;^UTILITY(U,$J,19200.114,43,"WP",1,0)
 ;;=--> H=Help
 ;;^UTILITY(U,$J,19200.114,43,"WP",2,0)
 ;;=This variable is needed to successfully add the FIRST subentry to a
 ;;^UTILITY(U,$J,19200.114,43,"WP",3,0)
 ;;=multiple when the header node of the multiple doesn't exist.
 ;;^UTILITY(U,$J,19200.114,43,"WP",4,0)
 ;;=Example: S DIC("P")=$P(^DD(16150,9,0),"^",2).
 ;;^UTILITY(U,$J,19200.114,43,"WP1",0)
 ;;=^^10^10^2960115^^
 ;;^UTILITY(U,$J,19200.114,43,"WP1",1,0)
 ;;=This variable is needed to successfully add the FIRST subentry to a
 ;;^UTILITY(U,$J,19200.114,43,"WP1",2,0)
 ;;=multiple when the descriptor node of the multiple does not exist. In
 ;;^UTILITY(U,$J,19200.114,43,"WP1",3,0)
 ;;=that situation, DIC("P") should be set equal to the subfile number and
 ;;^UTILITY(U,$J,19200.114,43,"WP1",4,0)
 ;;=subfile specifier codes for the multiple.
 ;;^UTILITY(U,$J,19200.114,43,"WP1",5,0)
 ;;= 
 ;;^UTILITY(U,$J,19200.114,43,"WP1",6,0)
 ;;=In order to automatically include any changes in the field's definition,
 ;;^UTILITY(U,$J,19200.114,43,"WP1",7,0)
 ;;=it is best to set this variable to the 2nd piece of the 0-node of the
