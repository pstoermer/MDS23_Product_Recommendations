import csv

def remove_second_row(csv_file):
    with open(csv_file, 'r', newline='') as file:
        rows = list(csv.reader(file))
    
    filtered_rows = [rows[i] for i in range(len(rows)) if i % 2 == 0]
    
    with open(csv_file, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(filtered_rows)

# Abruf des Datensets
csv_file = 'test2.csv'
remove_second_row(csv_file)
