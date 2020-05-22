IBDEI1FW ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23025,1,4,0)
 ;;=4^N99.821
 ;;^UTILITY(U,$J,358.3,23025,2)
 ;;=^5015969
 ;;^UTILITY(U,$J,358.3,23026,0)
 ;;=T88.8XXA^^105^1166^26
 ;;^UTILITY(U,$J,358.3,23026,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23026,1,3,0)
 ;;=3^Complic,Surgical/Medical Care NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,23026,1,4,0)
 ;;=4^T88.8XXA
 ;;^UTILITY(U,$J,358.3,23026,2)
 ;;=^5055814
 ;;^UTILITY(U,$J,358.3,23027,0)
 ;;=T81.83XA^^105^1166^173
 ;;^UTILITY(U,$J,358.3,23027,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23027,1,3,0)
 ;;=3^Persistent Postprocedural Fistula,Init Encntr
 ;;^UTILITY(U,$J,358.3,23027,1,4,0)
 ;;=4^T81.83XA
 ;;^UTILITY(U,$J,358.3,23027,2)
 ;;=^5054659
 ;;^UTILITY(U,$J,358.3,23028,0)
 ;;=T81.89XA^^105^1166^25
 ;;^UTILITY(U,$J,358.3,23028,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23028,1,3,0)
 ;;=3^Complic,Procedures NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,23028,1,4,0)
 ;;=4^T81.89XA
 ;;^UTILITY(U,$J,358.3,23028,2)
 ;;=^5054662
 ;;^UTILITY(U,$J,358.3,23029,0)
 ;;=T81.9XXA^^105^1166^24
 ;;^UTILITY(U,$J,358.3,23029,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23029,1,3,0)
 ;;=3^Complic,Procedure Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,23029,1,4,0)
 ;;=4^T81.9XXA
 ;;^UTILITY(U,$J,358.3,23029,2)
 ;;=^5054665
 ;;^UTILITY(U,$J,358.3,23030,0)
 ;;=T85.810A^^105^1166^48
 ;;^UTILITY(U,$J,358.3,23030,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23030,1,3,0)
 ;;=3^Embol d/t Nervous System Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,23030,1,4,0)
 ;;=4^T85.810A
 ;;^UTILITY(U,$J,358.3,23030,2)
 ;;=^5140309
 ;;^UTILITY(U,$J,358.3,23031,0)
 ;;=T85.818A^^105^1166^49
 ;;^UTILITY(U,$J,358.3,23031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23031,1,3,0)
 ;;=3^Embol d/t Oth Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,23031,1,4,0)
 ;;=4^T85.818A
 ;;^UTILITY(U,$J,358.3,23031,2)
 ;;=^5140312
 ;;^UTILITY(U,$J,358.3,23032,0)
 ;;=T85.820A^^105^1166^55
 ;;^UTILITY(U,$J,358.3,23032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23032,1,3,0)
 ;;=3^Fibrosis d/t Nervous System Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,23032,1,4,0)
 ;;=4^T85.820A
 ;;^UTILITY(U,$J,358.3,23032,2)
 ;;=^5140315
 ;;^UTILITY(U,$J,358.3,23033,0)
 ;;=T85.828A^^105^1166^56
 ;;^UTILITY(U,$J,358.3,23033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23033,1,3,0)
 ;;=3^Fibrosis d/t Other Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,23033,1,4,0)
 ;;=4^T85.828A
 ;;^UTILITY(U,$J,358.3,23033,2)
 ;;=^5140318
 ;;^UTILITY(U,$J,358.3,23034,0)
 ;;=T85.830A^^105^1166^61
 ;;^UTILITY(U,$J,358.3,23034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23034,1,3,0)
 ;;=3^Hemorrh d/t Nervous System Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,23034,1,4,0)
 ;;=4^T85.830A
 ;;^UTILITY(U,$J,358.3,23034,2)
 ;;=^5140321
 ;;^UTILITY(U,$J,358.3,23035,0)
 ;;=T85.838A^^105^1166^62
 ;;^UTILITY(U,$J,358.3,23035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23035,1,3,0)
 ;;=3^Hemorrh d/t Other Internal Prosthetic Device/Implant/Graft,Init Encntr
 ;;^UTILITY(U,$J,358.3,23035,1,4,0)
 ;;=4^T85.838A
 ;;^UTILITY(U,$J,358.3,23035,2)
 ;;=^5140324
 ;;^UTILITY(U,$J,358.3,23036,0)
 ;;=T83.61XA^^105^1166^77
 ;;^UTILITY(U,$J,358.3,23036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23036,1,3,0)
 ;;=3^Infect/Inflm Reaction d/t Implanted Penile Prosthesis,Init Encntr
