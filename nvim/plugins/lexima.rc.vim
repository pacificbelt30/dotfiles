call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': ['tex', 'latex']})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave':1, 'filetype': ['tex', 'latex']})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': ['tex','latex']})
