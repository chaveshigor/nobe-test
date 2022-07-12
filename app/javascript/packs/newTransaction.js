const transaction_type_field = document.getElementById('transaction_transaction_type')
const receiver_field = document.getElementById('account_receiver_number_field')

transaction_type_field.addEventListener('change', () => {
  let current_type = transaction_type_field.value
  receiver_field.style.display = setDisplay(current_type, receiverDisplay)
})

function setDisplay(transactionType, fieldDisplay) {
  return fieldDisplay[transactionType]
}

const receiverDisplay = {
  '': 'none',
  '0': 'none',
  '1': 'block',
  '2': 'block'
}