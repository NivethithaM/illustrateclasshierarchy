package User;

use Data::Dumper;

#Set Username
sub SetUserName {
	my ($self,$args) = @_;
	$self->{CREDENTIAL}{USERNAME} = $args->{USERNAME};
	return;
}

#Set Password
sub SetPassword {
	my ($self,$args) = @_;
	$self->{CREDENTIAL}{PASSWORD} = $args->{PASSWORD};
	return;
}

#Set IsAdmin or not
sub SetIsAdmin {
	my ($self,$args) = @_;
	$self->{CREDENTIAL}{ISADMIN} = $args->{ISADMIN};
	return;
}

#Set IsEmployee or not
sub SetIsEmployee {
	my ($self,$args) = @_;
	$self->{CREDENTIAL}{ISEMPLOYEE} = $args->{ISEMPLOYEE};
	return;
}

#Function to Register Employee or Admin
sub UserRegister {
	my ($self,$args) = @_;
	$self->SetUserName({
		USERNAME => $args->{USERNAME},
	});
	$self->SetPassword({
		PASSWORD => $args->{PASSWORD},
	});
	$self->SetIsAdmin({
		ISADMIN => $args->{ISADMIN},
	});
	$self->SetIsEmployee({
		ISEMPLOYEE => $args->{ISEMPLOYEE},
	});
	return;
}

#Validate whether the User is admin or not
sub IsAdmin {
	my ($self,$args) = @_;
	my @isadmin = grep {$_->{USERNAME} eq $args->{USERNAME}} $self->{CREDENTIAL};
	return $isadmin[0]->{ISADMIN};
}

#Validate whether the User is Employee or not
sub IsEmployee {
	my ($self,$args) = @_;
	my @isemployee = grep {$_->{USERNAME} eq $args->{USERNAME}} $self->{CREDENTIAL};
	return $isemployee[0]->{ISEMPLOYEE};
}

#Function to Login
sub Login {
	my ($self,$args) = @_;
	if ($self->{CREDENTIAL}{USERNAME} eq $args->{USERNAME} && $self->{CREDENTIAL}{PASSWORD} == $args->{PASSWORD}) {
		return "Logged in successfully";	
	} else {
		return "Invalid Username and password";
	}
}
1
