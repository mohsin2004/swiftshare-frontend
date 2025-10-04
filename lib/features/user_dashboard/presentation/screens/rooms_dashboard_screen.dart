import 'package:flutter/material.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<Map<String, dynamic>> _rooms = [];
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    // Initialize with some sample rooms
    _rooms = [
      {
        'id': 1,
        'name': 'Movie Night',
        'members': 5,
        'isLocked': false,
        'maxMembers': 10,
        'currentMedia': 'Inception (2010)',
      },
      {
        'id': 2,
        'name': 'Study Group',
        'members': 3,
        'isLocked': true,
        'maxMembers': 8,
        'currentMedia': 'Documentary Series',
      },
      {
        'id': 3,
        'name': 'Gaming Room',
        'members': 7,
        'isLocked': false,
        'maxMembers': 15,
        'currentMedia': 'Action Games',
      },
      {
        'id': 4,
        'name': 'Music Lovers',
        'members': 4,
        'isLocked': true,
        'maxMembers': 6,
        'currentMedia': 'Concert Replay',
      },
      {
        'id': 5,
        'name': 'Tech Talk',
        'members': 6,
        'isLocked': false,
        'maxMembers': 12,
        'currentMedia': 'Tech Reviews',
      },
    ];
    _searchResults = List.from(_rooms);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = List.from(_rooms);
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults = _rooms.where((room) {
        return room['name'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showCreateRoomDialog() {
    final TextEditingController nameController = TextEditingController();
    bool isLocked = false;
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController maxMembersController = TextEditingController(text: '10');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1A1A1A),
              title: const Text(
                'Create Room',
                style: TextStyle(color: Colors.white),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Room Name',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6B73FF)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text(
                        'Lock Room',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: isLocked,
                      onChanged: (value) {
                        setState(() {
                          isLocked = value;
                        });
                      },
                      activeColor: const Color(0xFF6B73FF),
                    ),
                    if (isLocked)
                      TextField(
                        controller: passwordController,
                        style: const TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Room Password',
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF6B73FF)),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: maxMembersController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Maximum Members',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6B73FF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Create room logic
                    if (nameController.text.isNotEmpty) {
                      final newRoom = {
                        'id': _rooms.length + 1,
                        'name': nameController.text,
                        'members': 1,
                        'isLocked': isLocked,
                        'maxMembers': int.tryParse(maxMembersController.text) ?? 10,
                        'currentMedia': 'No media playing',
                      };
                      setState(() {
                        _rooms.add(newRoom);
                        if (!_isSearching) {
                          _searchResults = List.from(_rooms);
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Create',
                    style: TextStyle(color: Color(0xFF6B73FF)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _joinRoom(Map<String, dynamic> room) {
    if (room['isLocked']) {
      _showPasswordDialog(room);
    } else {
      _navigateToRoom(room);
    }
  }

  void _showPasswordDialog(Map<String, dynamic> room) {
    final TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text(
            'Enter Room Password',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6B73FF)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                // In a real app, you would verify the password here
                // For now, we'll just proceed
                Navigator.pop(context);
                _navigateToRoom(room);
              },
              child: const Text(
                'Join',
                style: TextStyle(color: Color(0xFF6B73FF)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToRoom(Map<String, dynamic> room) {
    // Navigate to room screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joining room: ${room['name']}'),
        backgroundColor: const Color(0xFF6B73FF),
      ),
    );
    // TODO: Implement actual room navigation
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0A0A),
      child: Column(
        children: [
          _buildRoomsHeader(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCreateRoomCard(), // Add the Create Room card back
                  const SizedBox(height: 24),
                  _buildActiveRoomsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomsHeader() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const Text(
            'Rooms',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              _showSearchDialog(); // Use the existing search dialog method
            },
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    final TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text(
            'Search Rooms',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: searchController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search for rooms...',
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6B73FF)),
              ),
            ),
            onSubmitted: (value) {
              _performSearch(value);
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                _performSearch(searchController.text);
                Navigator.pop(context);
              },
              child: const Text(
                'Search',
                style: TextStyle(color: Color(0xFF6B73FF)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActiveRoomsSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active Rooms',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _searchResults.isEmpty
                ? const Center(
                    child: Text(
                      'No rooms found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return _buildRoomItem(_searchResults[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateRoomCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B73FF), Color(0xFF9575FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6B73FF).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create a Room',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start watching together with friends',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _showCreateRoomDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF6B73FF),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Create Room',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomItem(Map<String, dynamic> room) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2A2A2A),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B73FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.group,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      room['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${room['members']} / ${room['maxMembers']} members',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (room['isLocked'])
                const Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 16,
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Live',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Currently watching: ${room['currentMedia']}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _joinRoom(room),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B73FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Join Room'),
            ),
          ),
        ],
      ),
    );
  }
}