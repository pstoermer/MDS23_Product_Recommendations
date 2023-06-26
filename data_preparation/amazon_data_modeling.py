import os
import argparse

import pandas as pd


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("-i",
                        "--input",
                        type=str,
                        help = "Define input path. (CSV FILE)",
                        required=True
                        )
    parser.add_argument("-o",
                        "--output",
                        type=str,
                        help="Define output path. (DIRECTORY)",
                        required=True
                        )

    # Read arguments from command line
    args = parser.parse_args()

    amazon_df = pd.read_csv(args.input_path)

    # Split Data according to Tables
    user_df = amazon_df['UserId'].drop_duplicates()
    product_df = amazon_df[['ProductId',
                            'ProductType',
                            'URL']].drop_duplicates(subset='ProductId')

    rating_df = amazon_df[['Rating',
                           'Timestamp',
                           'ProductId',
                           'UserId']]

    # Save to Files
    user_df.to_csv(os.path.join(args.output, 'user.csv'),
                   index=False)
    product_df.to_csv(os.path.join(args.output, 'product.csv'), index=False)
    rating_df.to_csv(os.path.join(args.output, 'rating.csv'), index=False)

if __name__ == '__main__':
    main()
