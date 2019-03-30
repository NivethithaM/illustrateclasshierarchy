package Items;

use Vegetables;
use Fruits;
use Spices;
use Cookies;
use List::Util;
use Data::Dumper;

#Admin can additems to inventory
sub AddItems {
	my ($self,$args) = @_;
	my $isadmin = $self->IsAdmin({
		USERNAME => 'Priya',
	});
	if ($isadmin) {
		push(@{$self->{ITEMS}}, @{$args->{ITEMS}});
		for ($self->Items('ITEMS')) {
			$self->AddPrice({
				Item => $_
			});	
			$self->AddQuantity({
				Quantity => $_
			});
		}
		return "Added Items to inventory and set price and quantity for all the items";
	} else {
		return "Not authorized to add items";
	}
}

#Get the category if sub-category item is passed
sub GetCategory {
	my ($self,$args) = @_;
	if (List::Util::any($args->{ITEMS},qw(CARROT BEANS TOMATO ONION))) {
		return 'Vegetables';
	} elsif (List::Util::any($args->{ITEMS},qw(POMO ORANGE GRAPES))) {
		return 'Fruits';
	} elsif (List::Util::any($args->{ITEMS},qw(HIDEANDSEEK PARLEG MILKBIKIS TIGER))) {
		return 'Cookies';
	} elsif (List::Util::any($args->{ITEMS},qw(CARDOMOM PEPPER))) {
		return 'Spices';
	}
}

#returns list of items
sub Items {
	my ($self,$args) = @_;
	return @{$self->{$args}};
}

#Add price for each sub-category item in the inventory
sub AddPrice {
	my ($self,$args) = @_;
	my $item = $args->{Item};
	my $pricelist = $item->AddPrice();
	push (@{$self->{$item}},$pricelist);
}

#Initialize total number of quantity for each sub-category item
sub AddQuantity {
	my ($self,$args) = @_;
	my $quantity = $args->{Quantity};
	my $quantitylist = $quantity->AddQuantity();
	push (@{$self->{$quantity . "quantity"}},$quantitylist);
}

#Get total number of items in the inventory
sub GetInventoryItems {
	my ($self,$args) = @_;
	my $totalitemquantity;
	for my $item ($self->Items('ITEMS')) {
		if (!$totalitemquantity->{$item}) {
			$totalitemquantity->{$item} = $self->{$item}[0];
			$totalitemquantity->{$item ."quantity"} = $self->{$item."quantity"}[0];
		}
	}
	return $totalitemquantity;
}

#Get price for each individual item
sub GetPricePerQuantity {
	my ($self,$args) = @_;
	my $totalinventoryitem = $self->GetInventoryItems();
	my $product = $args->{PURCHASEITEM};
	my $priceperitem;
	foreach my $item (keys %$totalinventoryitem) {
		if ($item !~ m/quantity/ && defined $totalinventoryitem->{$item}->{$product}) {
			$priceperitem = $totalinventoryitem->{$item}->{$product};
		}
	}
	return $priceperitem;
}

#Records the items that are being sold
sub TrackPurchaseItem {
	my ($self,$args) = @_;
	my $purchaseitem;
	my $totalinventoryitem = $self->GetInventoryItems();
	my $product = $args->{PURCHASEITEM};
	my $quantity = $args->{PURCHASEQUANTITY};
	foreach my $item (keys %$totalinventoryitem) {
		if ($item =~ m/quantity/ && defined $totalinventoryitem->{$item}->{$product}) {
			$purchaseitem->{$product} += $totalinventoryitem->{$item}->{$product} - $quantity;
			push (@{$self->{PURCHASEITEM}},$purchaseitem);
		}
	}
}

#Gets the remaining items in the inventory
sub GetRemainingInventoryItem {
	my ($self,$args) = @_;
	my $totalinventoryitem = $self->GetInventoryItems();
	foreach my $val (@{$self->{PURCHASEITEM}}) {
		foreach my $key (keys %$val) {
			for($self->Items('ITEMS')) {
				if ($totalinventoryitem->{$_ . "quantity"}->{$key}) {
				$totalinventoryitem->{$_ . "quantity"}->{$key} = $val->{$key};
				}
			}
		}
	}
	return $totalinventoryitem;
}

#If Discount needs to be performed for all the items,
#Parent class will be called for any discount if DISCOUNTALLITEM
#argument is passed.
sub Discount {
        my ($self,$args) = @_;
        my $discount = 0;
        if ($args->{DISCOUNTALLITEM}) {
                $discount = $args->{DISCOUNTALLITEM};
        }
        return $discount
}
1
