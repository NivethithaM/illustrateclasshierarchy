package GroceryStore;

use base 'Items','User','Transaction';
use Data::Dumper;

#Creates instance of a class
sub new {
	my ($class) = @_;
	my $self = {};
	bless ($self,$class); #bless hash reference to a class;
	return $self;
}

#print receipt once after the transaction has completed
sub PrintReceipt {
	my ($self,$args) = @_;
	my $message = $self->SUPER::PrintReceipt($args);
	
	if ($message) {
		return $message;
	} else {
		return "No transaction to process\n";
	}
}

#Add discount for each class of Item by inheriting and set default 
#discount to employees for all class of items.
sub AddDiscount {
	my ($self,$args) = @_;
	my $isemployee = $self->IsEmployee({
		USERNAME => 'Priya',
	});
	my $discount = $self->SUPER::AddDiscount($args);
	if ($isemployee) {
		$discount += (50 / 100);
	}
	return $discount;
}
1
