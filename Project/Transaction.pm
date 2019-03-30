package Transaction;

use Data::Dumper;

#Gets the purchase items of the user as input and proccess
#total amount to be collected
sub ProcessTransaction {
	my ($self,$args) = @_;
	my $orders = $args;
	my $price;
	my $purchaseamt = 0;
	for my $item (keys %$args) {
		$price = $self->GetPricePerQuantity({
			PURCHASEITEM => $item
		});
		my $discount = $self->AddDiscount({
			PURCHASEITEM => $item
		});
		$purchaseamt += $args->{$item} * $price - $discount;
		$self->TrackPurchaseItem({
			PURCHASEITEM => $item,
			PURCHASEQUANTITY => $args->{$item},
		});
	}
	$self->TotalSales({AMOUNT => $purchaseamt});
	my $message = $self->PrintReceipt({
		TOTALAMOUNT => $purchaseamt
	});
	return $message;
}

#Keeps track of total sale for the day
sub TotalSales {
	my ($self,$args) = @_;
	my $sale = $args->{AMOUNT} || 0;
	return $self->{TOTALSALE} += $sale;
}

#Function to add discount if there is one for any class of item
sub AddDiscount {
	my ($self,$args) = @_;
	my $category = $self->GetCategory({
		ITEMS => $args->{PURCHASEITEM},
	});
	my $discount = 0;
	$discount += $category->Discount / 100;
	return $discount;
}

#Prints receipt 
sub PrintReceipt {
	my ($self,$args) = @_;
	return "Successfully processed your transaction of amount $args->{TOTALAMOUNT}";
}
1
