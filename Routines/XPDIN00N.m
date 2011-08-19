XPDIN00N ; ; 03-JUL-1995
 ;;8.0;KERNEL;;JUL 10, 1995
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","PT",9.6,1,8,51)
 ;;=
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,0,27)
 ;;=Edit a Build                          PAGE 1 OF 4
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,1,0)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,5,21)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,7,9)
 ;;=Date Distributed:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,9,14)
 ;;=Description:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,11,0)
 ;;=Environment Check Routine:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,13,6)
 ;;=Pre-Install Routine:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",1,15,5)
 ;;=Post-Install Routine:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",2,0,27)
 ;;=Edit a Build                          PAGE 3 OF 4
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",2,1,0)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",2,3,27)
 ;;=Build Components
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",4,0,27)
 ;;=Edit a Build                          PAGE 2 OF 4
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",4,1,0)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",4,3,27)
 ;;=File List  (Name or Number)
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",5,5,26)
 ;;= Affects Record Merge 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",5,7,4)
 ;;=File Affected:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",5,9,4)
 ;;=Name of Merge Routine:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",5,12,24)
 ;;=Record has Package Data
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,1,27)
 ;;= Install Questions 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,2,6)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,4,4)
 ;;=DIR(0):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,4,4,"A")
 ;;=1;6;U
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,6,4)
 ;;=DIR(A):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,7,2)
 ;;=DIR(A,#):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,9,4)
 ;;=DIR(B):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,11,4)
 ;;=DIR(?):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,12,2)
 ;;=DIR(?,#):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,13,3)
 ;;=DIR(??):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",6,15,4)
 ;;=M Code:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",7,4,26)
 ;;= DD Export Options 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",7,6,23)
 ;;=File:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",7,8,4)
 ;;=Send Full or Partial DD...:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",7,10,1)
 ;;=Update the Data Dictionary:             Send Security Code:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",7,12,1)
 ;;=Screen to Determine DD Update
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",7,15,7)
 ;;=Data Comes With File...:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",8,4,27)
 ;;= Edit PACKAGE File 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",8,5,3)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",8,8,12)
 ;;=Primary Help Frame:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",8,10,3)
 ;;=Select Affects Record Merge:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",8,12,9)
 ;;=Alpha/Beta Testing...:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",9,3,28)
 ;;= Alpha/Beta Testing 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",9,5,10)
 ;;=Installation Message:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",9,7,3)
 ;;=Address for Usage Reporting:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",9,9,3)
 ;;=Package Namespace or Prefix:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",10,4,24)
 ;;= Exclude Namespace or Prefix 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",11,5,26)
 ;;= Data Dictionary Number 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",12,6,26)
 ;;= Field Number 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",13,5,29)
 ;;= Data Export Options 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",13,7,8)
 ;;=Site's Data:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",13,9,3)
 ;;=Resolve Pointers:                 May User Override Data Update:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",13,11,10)
 ;;=Data List:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",13,13,3)
 ;;=Screen to Select Data
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",14,0,27)
 ;;=Edit a Build                          PAGE 4 OF 4
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",14,1,0)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",14,3,27)
 ;;=Install Questions
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",14,14,4)
 ;;=Package File Link...:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",14,16,0)
 ;;=Track Package Nationally:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,1,26)
 ;;= Install Questions 
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,2,5)
 ;;=Name:
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,4,3)
 ;;=DIR(0):
 ;;^UTILITY(U,$J,"DIST(.403,",11,"AZ","X",15,4,3,"A")
 ;;=1;6;U
