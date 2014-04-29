
NDEBUG    := t 
MPI       :=  
OMP       :=  
PROF      :=
COMP      := gfortran
MKVERBOSE := t
#USE_C_FUNC := 
USE_C_FUNC := t 

#USE_IPM   := t

include ./F_mk/GMakedefs.mak

include ./GPackage.mak
VPATH_LOCATIONS += .

include ./F_BaseLib/GPackage.mak
VPATH_LOCATIONS += ./F_BaseLib

#libraries += $(IPM_GNU)

main.$(suf).exe: $(objects)
	$(LINK.f90) -o main.$(suf).exe $(objects) $(libraries)

include ./F_mk/GMakerules.mak
