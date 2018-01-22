//
//  UsuariosTableViewController.m
//  PruebasJSONRed
//
//  Created by cice on 22/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import "UsuariosTableViewController.h"

@interface UsuariosTableViewController ()

@property (nonatomic) NSArray *usuarios;

@end

@implementation UsuariosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // ESTO ERA LA DESCARGA SINCRONA QUE ES MUY PESADA
    /*
    NSURL *url = [NSURL URLWithString:@"https://pastebin.com/raw/np1sy4AT"];
    //NSURL *url = [NSURL URLWithString:@"https://twitter.com"];
    NSData *urldata = [NSData dataWithContentsOfURL:url];
    
    //NSString *codigoPagina = [[NSString alloc] initWithData:urldata encoding:NSUTF8StringEncoding];
    
    //NSLog(@"%@", codigoPagina);
    
    self.usuarios = [NSJSONSerialization JSONObjectWithData:urldata options:0 error:nil];*/
    
    
    // DESCARGA ASÍNCRONA
    NSURL *url = [NSURL URLWithString:@"https://pastebin.com/raw/np1sy4AT"];
    NSURLSessionDataTask *descargaURL = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                                    completionHandler:^(NSData * _Nullable data,
                                                                                        NSURLResponse * _Nullable response,
                                                                                        NSError * _Nullable error) {
                                                                        if(error == nil)
                                                                        {
                                                                            self.usuarios = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                                            
                                                                            
                                                                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                                // Esta instrucción debe usarse explicitamente en primer plano. De ahí que la metamos en el main queue
                                                                                [self.tableView reloadData];
                                                                            }];
                                                                        }
    }];
    
    [descargaURL resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usuarios.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celdaUsuario" forIndexPath:indexPath];
    
    // Configure the cell...

    NSDictionary *usuario = self.usuarios[indexPath.row];
    cell.textLabel.text = usuario[@"usuario"];
    cell.detailTextLabel.text = usuario[@"email"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
