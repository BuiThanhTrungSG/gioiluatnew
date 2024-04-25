class Menu {

  late String name;
  List<Menu> subMenu = [];

  Menu(this.name, this.subMenu);

  Menu.fromJson(Map<String, dynamic> json){
    name = json['name'];
    if(json['subMenu'] != null) {
      subMenu.clear();
      json['subMenu'].forEach((v) {
        subMenu.add(Menu.fromJson(v));
      });
    }
  }
}

List datalist = [
  {
    'name': 'Chương 1: Nhuwng quy dinh chung trong bo luat tot tung hinh du svaf cac van de luo quna',
    'subMenu': [
      {
        'name': 'Muc 1: Gioi thieu thanh phan',
        'subMenu': [
      {
      'name': 'Dieu 1'
      },
      {
      'name': 'Dieu 2'
      }
      ]
      },
      {
        'name': 'Muc 2: Nghien cuc cac van de co trong tu nhien va xax hoi hung khong anh huong dne moi troung xuong quanh cua ban',
        'subMenu': [
          {
            'name': 'Dieu 3'
          },
          {
            'name': 'Dieu 4'
          }
      ]
      }
    ]
  },
  {
    'name': 'Chương 2',
    'subMenu': [
      {
        'name': 'Muc 1',
        'subMenu': [
          {
            'name': 'Dieu 1'
          },
          {
            'name': 'Dieu 2'
          }
        ]
      },
      {
        'name': 'Muc 2',
        'subMenu': [
          {
            'name': 'Dieu 3'
          },
          {
            'name': 'Dieu 4'
          }
        ]
      }
    ]
  },
];