ENFARC2 ;WIRMFO/SAB-FIXED ASSET RPT, TRANSACTION REGISTER (CONT); 12/16/1998
 ;;7.0;ENGINEERING;**39,60**;Aug 17, 1993
 Q
 ;This routine contains detail prints for FAP Document types
 ;It is called from ENFARC1 and ENFAR9 - needs at 6+ blank lines
 ; Input
 ;   END          - flag; true when quit
 ;   ENDA("F?")   - ien of document being printed
 ;   ENDA("FA")   - ien of FA document associated with the ENDA("F?")
 ;   ENDA("EQ")   - ien of the equipment entry for ENDA("F?")
 ;   ENTAG("HD")  - (optional) line TAG for page header
 ;   ENTAG("HDC") - (optional) line tag for page header continued note
 ;   ENTAG("FT")  - (optional) lien tag for page footer
 ; Output
 ;   END          - flag; true when quit
 ;
F2 ; print FA details (5 lines)
 N ENX,ENY3
 S ENY3=$G(^ENG(6915.2,ENDA("F?"),3))
 S ENX=$P(ENY3,U,15)
 S ENX(0)=$S(ENX]"":$O(^ENCSN(6917,"B",ENX,0)),1:"")
 S ENX("D")=$S(ENX(0):$P($G(^ENCSN(6917,ENX(0),0)),U,3),1:"")
 ; if called by Document History - display fund since it is not
 ;   shown on a column
 I $G(ENTAG("HD"))["ENFAR9" W ?4,"FUND: ",$P(ENY3,U,10)
 W ?25,"CSN: ",ENX W:ENX("D")]"" " (",ENX("D"),")"
 ; if xarea available then display it, otherwise display location
 I $P(ENY3,U,31)]"" W !,?4,"CMR: ",$P(ENY3,U,31)
 E  W !,?4,"NATIONAL EIL: ",$P(ENY3,U,8)
 W ?25,"COST CENTER: ",$P(ENY3,U,28)
 S ENX=$P(ENY3,U,19)
 W ?48,"ACQ METH: ",$$EXTERNAL^DILFD(6914,20.1,"",ENX)
 W !,?4,"ACQ DATE: ",$P(ENY3,U,17),"/",$P(ENY3,U,18),"/",$E($P(ENY3,U,16),3,4)
 W ?25,"LE: ",$P(ENY3,U,24)
 W ?48,"REPL DATE: ",$P(ENY3,U,22),"/",$P(ENY3,U,23),"/",$E($P(ENY3,U,21),3,4)
 W !,?4,"BOC: ",$P(ENY3,U,14),?25,"A/O: ",$P(ENY3,U,11)
 S ENX=$P($G(^ENG(6915.2,ENDA("F?"),7)),U,2)
 W ?48,"EQUITY ACCOUNT: ",$$EXTERNAL^DILFD(6914,64,"",ENX)
 W !,?4,"P.O.#: " W:ENDA("EQ") $P($G(^ENG(6914,ENDA("EQ"),2)),U,2)
 Q
F3 ; print FB details (2 lines)
 N ENX,ENY3
 S ENY3=$G(^ENG(6915.3,ENDA("F?"),3))
 W ?25,"DESCRIPTION: ",$P(ENY3,U,8)
 W !,?4,"P.O.#: " W:ENDA("EQ") $P($G(^ENG(6914,ENDA("EQ"),2)),U,2)
 W ?25,"ACQ DATE: ",$P(ENY3,U,10),"/",$P(ENY3,U,11),"/",$E($P(ENY3,U,9),3,4)
 S ENX=$P(ENY3,U,12)
 W ?48,"ACQ METH: ",$$EXTERNAL^DILFD(6914,20.1,"",ENX)
 Q
F4 ; print FC details (1-9 lines)
 N EN,ENX,ENY3,ENY4,ENY100
 W ?25,"P.O.#: " W:ENDA("EQ") $P($G(^ENG(6914,ENDA("EQ"),2)),U,2)
 D FCPVAL^ENFARC3(6915.4,ENDA("F?"),ENDA("FA"))
 S ENY3=$G(^ENG(6915.4,ENDA("F?"),3))
 S ENY4=$G(^ENG(6915.4,ENDA("F?"),4))
 S ENY100=$G(^ENG(6915.4,ENDA("F?"),100))
 I $P(ENY3,U,11)]"",$P(ENY3,U,11)'=EN(30) D  Q:END
 . I $Y+7>IOSL D FT,HD Q:END  D HDC
 . W !,?4,$S($P(ENY3,U,8)="00":"CSN",1:"DESCRIPTION")," CHANGED"
 . W ?25,"OLD: ",EN(30)
 . I $P(ENY3,U,8)="00" D  ; show CSN brief desc
 . . S ENX(0)=$S(EN(30)]"":$O(^ENCSN(6917,"B",EN(30),0)),1:"")
 . . S ENX("D")=$S(ENX(0):$P($G(^ENCSN(6917,ENX(0),0)),U,3),1:"")
 . . W:ENX("D")]"" " (",ENX("D"),")"
 . W !,?25,"NEW: ",$P(ENY3,U,11)
 . I $P(ENY3,U,8)="00" D  ; show CSN brief desc
 . . S ENX(0)=$S($P(ENY3,U,11)]"":$O(^ENCSN(6917,"B",$P(ENY3,U,11),0)),1:"")
 . . S ENX("D")=$S(ENX(0):$P($G(^ENCSN(6917,ENX(0),0)),U,3),1:"")
 . . W:ENX("D")]"" " (",ENX("D"),")"
 I $P(ENY3,U,10)]"",$P(ENY3,U,10)'=EN(29) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"NATIONAL EIL CHANGED "
 . W ?25,"OLD: ",EN(29),?53,"NEW: ",$P(ENY3,U,10)
 I $P(ENY3,U,15)]"",$P(ENY3,U,15)'=EN(34) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"ACQ METHOD CHANGED "
 . W ?25,"OLD: ",$$EXTERNAL^DILFD(6914,20.1,"",EN(34))
 . W ?53,"NEW: ",$$EXTERNAL^DILFD(6914,20.1,"",$P(ENY3,U,15))
 I $P(ENY100,U,6)]"",$P(ENY100,U,6)'=EN(105) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"ACQ DATE CHANGED "
 . W ?25,"OLD: ",$$FMTE^XLFDT(EN(105))
 . W ?53,"NEW: ",$$FMTE^XLFDT($P(ENY100,U,6))
 I $P(ENY4,U,3)]"",$P(ENY4,U,3)'=EN(37) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"USEFUL LIFE CHANGED "
 . W ?25,"OLD: ",EN(37),?53,"NEW: ",$P(ENY4,U,3)
 I $P(ENY100,U,7)]"",$P(ENY100,U,7)'=EN(106) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"REPL DATE CHANGED "
 . W ?25,"OLD: ",$$FMTE^XLFDT(EN(106))
 . W ?53,"NEW: ",$$FMTE^XLFDT($P(ENY100,U,7))
 I $P(ENY4,U,6)]"",$P(ENY4,U,6)'=$P(ENY100,U,4) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"ASSET VALUE CHANGED "
 . W ?25,"OLD: ",$P(ENY100,U,4),?53,"NEW: ",$P(ENY4,U,6)
 Q
F5 ; print FD details (2 lines)
 N ENTY,ENY5
 S ENY5=$G(^ENG(6915.5,ENDA("F?"),5))
 S ENTY=$P($G(^ENG(6915.5,ENDA("F?"),100)),U)
 W ?25,$S(ENTY="T":"TURN-IN",1:"DISP")," DATE: "
 W $P(ENY5,U,6),"/",$P(ENY5,U,7),"/",$E($P(ENY5,U,5),3,4)
 W ?49,"DISP AUTHORITY: ",$P(ENY5,U,9)
 Q:ENTY="T"
 W !,?4,"SELLING PRICE: ",$P(ENY5,U,8)
 W ?34,"DISP METHOD: ",$$GET1^DIQ(6915.5,ENDA("F?"),"103:1")
 Q
F6 ; print FR details (0-5 lines)
 N EN,ENY3
 D FRPVAL^ENFARC3(6915.6,ENDA("F?"),ENDA("FA"))
 S ENY3=$G(^ENG(6915.6,ENDA("F?"),3))
 I $P(ENY3,U,9)]"",$P(ENY3,U,9)'=EN(28) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"FUND CHANGED ",?25,"OLD: ",EN(28),?53,"NEW: ",$P(ENY3,U,9)
 I $P(ENY3,U,10)]"",$P(ENY3,U,10)'=EN(29) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"A/O CHANGED ",?25,"OLD: ",EN(29),?53,"NEW: ",$P(ENY3,U,10)
 I $P(ENY3,U,13)]"",$P(ENY3,U,13)'=EN(32) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"BOC CHANGED ",?25,"OLD: ",EN(32),?53,"NEW: ",$P(ENY3,U,13)
 I $P(ENY3,U,18)]"",$P(ENY3,U,18)'=EN(37) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"CMR CHANGED "
 . W ?25,"OLD: ",EN(37),?53,"NEW: ",$P(ENY3,U,18)
 ; only check location when we don't have xarea (cmr)
 I $P(ENY3,U,18)="",$P(ENY3,U,14)]"",$P(ENY3,U,14)'=EN(33) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"NATIONAL EIL CHANGED "
 . W ?25,"OLD: ",EN(33),?53,"NEW: ",$P(ENY3,U,14)
 I $P(ENY3,U,15)]"",$P(ENY3,U,15)'=EN(34) D  Q:END
 . I $Y+6>IOSL D FT,HD Q:END  D HDC
 . W !,?4,"COST CENTER CHANGED "
 . W ?25,"OLD: ",EN(34),?53,"NEW: ",$P(ENY3,U,15)
 Q
 ;
HD ; call page header
 I $G(ENTAG("HD"))]"" D @ENTAG("HD")
 Q
HDC ; call page header continued
 I $G(ENTAG("HDC"))]"" D @ENTAG("HDC")
 Q
FT ; call page footer
 I $G(ENTAG("FT"))]"" D @ENTAG("FT")
 Q
 ;ENFARC2
